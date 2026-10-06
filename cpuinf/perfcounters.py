"""In-process hardware performance counters via the perf_event_open syscall.

`perf stat python script.py` measures the whole process: interpreter start-up,
imports, model construction and inference all mixed together. To attribute
counts to one operator we need to start and stop counting *around a specific
region of Python code*. This module does that with ctypes:

    with CounterSession(["cycles", "instructions"]) as s:
        s.start(); op(x); counts = s.stop()

Event names are resolved the same way perf resolves them:
  * generic hardware/software names  -> PERF_TYPE_HARDWARE / PERF_TYPE_SOFTWARE
  * kernel-exported PMU events       -> /sys/bus/event_source/devices/<pmu>/events
  * perf's JSON event tables         -> encodings from `perf list --details`
and raw fields (event, umask, cmask, ...) are packed into config words using
the bit layout the kernel publishes in /sys/bus/event_source/devices/<pmu>/format.

Counting is per-thread (pid=0, cpu=-1): only the calling thread is counted,
on whatever CPU it runs on. Uncore events are socket-wide and need cpu>=0.
"""
from __future__ import annotations

import ctypes
import functools
import os
import re
import struct
import subprocess
from dataclasses import dataclass
from pathlib import Path

PMU_ROOT = Path("/sys/bus/event_source/devices")

PERF_TYPE_HARDWARE = 0
PERF_TYPE_SOFTWARE = 1

HW_EVENTS = {
    "cycles": 0, "cpu-cycles": 0, "instructions": 1, "cache-references": 2,
    "cache-misses": 3, "branches": 4, "branch-instructions": 4, "branch-misses": 5,
    "bus-cycles": 6, "ref-cycles": 9,
}
SW_EVENTS = {
    "cpu-clock": 0, "task-clock": 1, "page-faults": 2, "faults": 2,
    "context-switches": 3, "cs": 3, "cpu-migrations": 4, "migrations": 4,
    "minor-faults": 5, "major-faults": 6,
}

PERF_FORMAT_TOTAL_TIME_ENABLED = 1 << 0
PERF_FORMAT_TOTAL_TIME_RUNNING = 1 << 1
PERF_FORMAT_GROUP = 1 << 3

PERF_EVENT_IOC_ENABLE = 0x2400
PERF_EVENT_IOC_DISABLE = 0x2401
PERF_EVENT_IOC_RESET = 0x2403
PERF_IOC_FLAG_GROUP = 1

PR_TASK_PERF_EVENTS_DISABLE = 31
PR_TASK_PERF_EVENTS_ENABLE = 32

SYS_perf_event_open = 298  # x86-64


class PerfEventAttr(ctypes.Structure):
    _fields_ = [
        ("type", ctypes.c_uint32),
        ("size", ctypes.c_uint32),
        ("config", ctypes.c_uint64),
        ("sample_period", ctypes.c_uint64),
        ("sample_type", ctypes.c_uint64),
        ("read_format", ctypes.c_uint64),
        ("flags", ctypes.c_uint64),
        ("wakeup_events", ctypes.c_uint32),
        ("bp_type", ctypes.c_uint32),
        ("config1", ctypes.c_uint64),
        ("config2", ctypes.c_uint64),
        ("branch_sample_type", ctypes.c_uint64),
        ("sample_regs_user", ctypes.c_uint64),
        ("sample_stack_user", ctypes.c_uint32),
        ("clockid", ctypes.c_int32),
        ("sample_regs_intr", ctypes.c_uint64),
        ("aux_watermark", ctypes.c_uint32),
        ("sample_max_stack", ctypes.c_uint16),
        ("reserved_2", ctypes.c_uint16),
        ("aux_sample_size", ctypes.c_uint32),
        ("reserved_3", ctypes.c_uint32),
        ("sig_data", ctypes.c_uint64),
        ("config3", ctypes.c_uint64),
    ]


FLAG_DISABLED = 1 << 0
FLAG_EXCLUDE_KERNEL = 1 << 5
FLAG_EXCLUDE_HV = 1 << 6

_libc = ctypes.CDLL(None, use_errno=True)
_libc.syscall.restype = ctypes.c_long
_libc.ioctl.argtypes = [ctypes.c_int, ctypes.c_ulong, ctypes.c_ulong]
_libc.prctl.argtypes = [ctypes.c_int, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_ulong]


@dataclass
class EventEncoding:
    name: str
    pmu: str
    type: int
    config: int = 0
    config1: int = 0
    config2: int = 0
    source: str = ""


def _parse_format(pmu: str) -> dict:
    """Read /sys/.../<pmu>/format/* -> {field: [(config_word, lo, hi), ...]}."""
    fmt = {}
    for f in (PMU_ROOT / pmu / "format").iterdir():
        spec = f.read_text().strip()          # e.g. "config:8-15" or "config1:0-15"
        parts = []
        word, bits = spec.split(":")
        for rng in bits.split(","):
            lo, _, hi = rng.partition("-")
            parts.append((word, int(lo), int(hi or lo)))
        fmt[f.name] = parts
    return fmt


def _pack(pmu: str, terms: str) -> tuple[int, int, int]:
    """Pack 'event=0xd1,umask=0x1,cmask=2' into (config, config1, config2)."""
    fmt = _parse_format(pmu)
    words = {"config": 0, "config1": 0, "config2": 0}
    for term in terms.split(","):
        term = term.strip()
        if not term:
            continue
        k, _, v = term.partition("=")
        val = int(v, 0) if v else 1
        if k == "period":
            continue
        if k not in fmt:
            raise ValueError(f"unknown format field {k!r} for pmu {pmu}")
        for word, lo, hi in fmt[k]:
            width = hi - lo + 1
            words[word] |= (val & ((1 << width) - 1)) << lo
            val >>= width
    return words["config"], words["config1"], words["config2"]


@functools.lru_cache(maxsize=1)
def _json_event_table() -> dict:
    """Map lowercase perf JSON event name -> 'pmu/terms/' via `perf list --details`."""
    out = subprocess.run(["perf", "list", "--details"], capture_output=True, text=True).stdout
    table = {}
    current = None
    for line in out.splitlines():
        m = re.match(r"^  (\S+)\s*$", line)
        if m:
            current = m.group(1).lower()
            continue
        m = re.match(r"^\s+(\w+)/(.*)/\s*$", line)
        if m and current and current not in table:
            table[current] = (m.group(1), m.group(2))
    return table


def _pmu_type(pmu: str) -> int:
    return int((PMU_ROOT / pmu / "type").read_text())


@functools.lru_cache(maxsize=None)
def resolve(name: str) -> EventEncoding:
    """Resolve a perf event name to its perf_event_attr encoding."""
    lname = name.lower()
    if lname in HW_EVENTS:
        return EventEncoding(name, "hardware", PERF_TYPE_HARDWARE, HW_EVENTS[lname], source="generic hardware event")
    if lname in SW_EVENTS:
        return EventEncoding(name, "software", PERF_TYPE_SOFTWARE, SW_EVENTS[lname], source="generic software event")
    m = re.match(r"^(\w+)/([^/]*)/$", name)          # explicit pmu/event/ or pmu/terms/
    if m:
        pmu, inner = m.groups()
        ev_file = PMU_ROOT / pmu / "events" / inner
        terms = ev_file.read_text().strip() if ev_file.exists() else inner
        c, c1, c2 = _pack(pmu, terms)
        return EventEncoding(name, pmu, _pmu_type(pmu), c, c1, c2, source=f"sysfs {pmu}/events")
    ev_file = PMU_ROOT / "cpu" / "events" / name
    if ev_file.exists():
        c, c1, c2 = _pack("cpu", ev_file.read_text().strip())
        return EventEncoding(name, "cpu", _pmu_type("cpu"), c, c1, c2, source="kernel sysfs cpu/events")
    table = _json_event_table()
    if lname in table:
        pmu, terms = table[lname]
        if pmu == "default_core":
            pmu = "cpu"
        c, c1, c2 = _pack(pmu, terms)
        return EventEncoding(name, pmu, _pmu_type(pmu), c, c1, c2, source="perf JSON event table")
    raise KeyError(f"event {name!r} not found in generic, sysfs or perf JSON tables")


def _perf_event_open(attr: PerfEventAttr, pid: int, cpu: int, group_fd: int) -> int:
    fd = _libc.syscall(SYS_perf_event_open, ctypes.byref(attr), pid, cpu, group_fd, 0)
    if fd < 0:
        err = ctypes.get_errno()
        raise OSError(err, f"perf_event_open failed: {os.strerror(err)}")
    return fd


class CounterGroup:
    """One perf event group: members are scheduled onto the PMU together, so
    their counts cover exactly the same instants and ratios between them are exact."""

    def __init__(self, names: list[str], exclude_kernel: bool = False, pid: int = 0, cpu: int = -1):
        self.names = list(names)
        self.encodings = [resolve(n) for n in names]
        self.fds: list[int] = []
        leader = -1
        try:
            self._open_all(exclude_kernel, pid, cpu)
        except OSError:
            # Never leak a half-built group: prctl(PR_TASK_PERF_EVENTS_ENABLE)
            # would later re-enable it and it would steal counters.
            self.close()
            raise
        self._read_size = 8 * (3 + len(self.names))

    def _open_all(self, exclude_kernel, pid, cpu):
        leader = -1
        for i, enc in enumerate(self.encodings):
            attr = PerfEventAttr()
            attr.type = enc.type
            attr.size = ctypes.sizeof(PerfEventAttr)
            attr.config, attr.config1, attr.config2 = enc.config, enc.config1, enc.config2
            attr.read_format = (PERF_FORMAT_GROUP | PERF_FORMAT_TOTAL_TIME_ENABLED
                                | PERF_FORMAT_TOTAL_TIME_RUNNING)
            flags = FLAG_EXCLUDE_HV
            if exclude_kernel:
                flags |= FLAG_EXCLUDE_KERNEL
            if i == 0:
                flags |= FLAG_DISABLED
            attr.flags = flags
            fd = _perf_event_open(attr, pid, cpu, leader)
            if i == 0:
                leader = fd
                self.leader = fd
            self.fds.append(fd)

    def reset(self):
        _libc.ioctl(self.leader, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP)

    def enable(self):
        _libc.ioctl(self.leader, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP)

    def disable(self):
        _libc.ioctl(self.leader, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP)

    def read(self) -> tuple[dict, int, int]:
        buf = os.read(self.leader, self._read_size)
        nr, enabled, running, *vals = struct.unpack(f"{3 + len(self.names)}Q", buf)
        return dict(zip(self.names, vals)), enabled, running

    def close(self):
        for fd in reversed(self.fds):
            os.close(fd)
        self.fds = []


def split_into_groups(names: list[str]) -> list[list[str]]:
    """Software events and each hardware PMU go into separate groups; top-down
    events must share a group led by 'slots' (a kernel requirement)."""
    td = [n for n in names if n == "slots" or n.startswith("topdown-")]
    sw = [n for n in names if n.lower() in SW_EVENTS]
    unc = [n for n in names if n.startswith("uncore_")]
    rest = [n for n in names if n not in td and n not in sw and n not in unc]
    groups = []
    if td:
        td = ["slots"] + [n for n in td if n != "slots"]
        groups.append(td)
    if rest:
        groups.append(rest)
    if sw:
        groups.append(sw)
    return groups


class CounterSession:
    """Per-thread counters for one or more groups, enabled/disabled together.

    start()/stop() use prctl(PR_TASK_PERF_EVENTS_ENABLE/DISABLE): a single
    syscall that toggles every counter this thread owns, so the counted region
    begins and ends at the same instant for all groups.
    """

    def __init__(self, names: list[str], exclude_kernel: bool = False):
        self.groups = []
        try:
            for g in split_into_groups(names):
                self.groups.append(CounterGroup(g, exclude_kernel=exclude_kernel))
        except OSError:
            self.close()
            raise
        # Arm every group, then gate them all off. prctl only affects events
        # that already exist, so the order matters.
        for g in self.groups:
            g.enable()
        _libc.prctl(PR_TASK_PERF_EVENTS_DISABLE, 0, 0, 0, 0)

    def start(self):
        for g in self.groups:
            g.reset()
        _libc.prctl(PR_TASK_PERF_EVENTS_ENABLE, 0, 0, 0, 0)

    def stop(self) -> dict:
        _libc.prctl(PR_TASK_PERF_EVENTS_DISABLE, 0, 0, 0, 0)
        return self.read()

    def read(self) -> dict:
        out = {}
        multiplexed = False
        for g in self.groups:
            vals, enabled, running = g.read()
            if enabled and running < enabled:
                multiplexed = True
            out.update(vals)
        out["_multiplexed"] = multiplexed
        return out

    def close(self):
        for g in self.groups:
            g.close()

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        self.close()


def schedulable(names: list[str]) -> bool:
    """True if these events open as one session and count without multiplexing."""
    try:
        with CounterSession(names) as s:
            s.start()
            sum(i * i for i in range(20000))
            r = s.stop()
        return not r["_multiplexed"]
    except OSError:
        return False


def plan_groups(names: list[str], anchor: tuple = ("cycles",)) -> list[list[str]]:
    """Split an event list into the fewest sequential runs that each fit on the
    PMU without multiplexing (greedy, verified by actually opening them).

    Needed because some events may only use a subset of the counters (e.g.
    MEM_LOAD_RETIRED.* only on general-purpose counters 0-3 on this PMU), so
    "8 general-purpose counters" does not mean any 8 events fit together.
    Every run includes the anchor events (cycles) so each can be normalised.
    """
    if any(n == "slots" or n.startswith("topdown-") for n in names):
        return [list(names)]
    rest = [n for n in names if n not in anchor]
    runs, cur = [], []
    for n in rest:
        if schedulable(list(anchor) + cur + [n]):
            cur.append(n)
        else:
            if cur:
                runs.append(list(anchor) + cur)
            cur = [n]
    if cur or not runs:
        runs.append(list(anchor) + cur)
    return runs


class UncoreCounters:
    """Socket-wide uncore counters (e.g. DRAM CAS counts) summed over all PMU
    instances (uncore_imc_0..N). Requires perf_event_paranoid <= 0."""

    def __init__(self, event: str, terms_scale: float | None = None):
        m = re.match(r"^(uncore_\w+?)/([^/]+)/$", event)
        if not m:
            raise ValueError("expected uncore_<pmu>/<event>/")
        base, ev = m.groups()
        self.fds = []
        self.scale = terms_scale
        for d in sorted(PMU_ROOT.iterdir()):
            if re.fullmatch(base + r"_\d+", d.name) and (d / "events" / ev).exists():
                cpu = int((d / "cpumask").read_text().split(",")[0].split("-")[0])
                c, c1, c2 = _pack(d.name, (d / "events" / ev).read_text().strip())
                attr = PerfEventAttr()
                attr.type = _pmu_type(d.name)
                attr.size = ctypes.sizeof(PerfEventAttr)
                attr.config, attr.config1, attr.config2 = c, c1, c2
                attr.flags = 0
                attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
                self.fds.append(_perf_event_open(attr, -1, cpu, -1))
                sc = d / "events" / f"{ev}.scale"
                if self.scale is None and sc.exists():
                    self.scale = float(sc.read_text())
        if not self.fds:
            raise KeyError(f"no uncore PMU instances provide {event}")

    def read_raw(self) -> int:
        """Sum over instances. Raises if any instance was multiplexed, since
        socket-wide counts cannot be scaled reliably over short intervals."""
        total = 0
        for fd in self.fds:
            val, enabled, running = struct.unpack("QQQ", os.read(fd, 24))
            if running < enabled:
                raise RuntimeError("uncore counter multiplexed (running < enabled)")
            total += val
        return total

    def close(self):
        for fd in self.fds:
            os.close(fd)
