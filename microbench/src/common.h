// Shared helpers for the native microbenchmarks.
//
// Every benchmark prints CSV rows with the same columns:
//   bench,variant,ws_bytes,param,rep,iters,ns,cycles,ref_cycles,instructions,work,work_unit
// `work` is the number of useful units performed in the timed region
// (operations, FLOPs, bytes or loads, named by work_unit). Analysis divides
// work by ns or cycles; nothing is pre-aggregated here, so raw data is kept.
#pragma once

#include <linux/perf_event.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <unistd.h>

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <string>

static inline double now_ns() {
    timespec ts;
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    return ts.tv_sec * 1e9 + ts.tv_nsec;
}

// cycles, ref-cycles and instructions for the calling thread, as one group so
// they are always scheduled together.
struct Counters {
    int fd[3] = {-1, -1, -1};
    bool ok = false;

    Counters() {
        const uint64_t cfg[3] = {PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_REF_CPU_CYCLES,
                                 PERF_COUNT_HW_INSTRUCTIONS};
        for (int i = 0; i < 3; i++) {
            perf_event_attr a;
            memset(&a, 0, sizeof(a));
            a.type = PERF_TYPE_HARDWARE;
            a.size = sizeof(a);
            a.config = cfg[i];
            a.disabled = (i == 0);
            a.exclude_hv = 1;
            a.read_format = PERF_FORMAT_GROUP;
            fd[i] = (int)syscall(SYS_perf_event_open, &a, 0, -1, i == 0 ? -1 : fd[0], 0);
            if (fd[i] < 0) {
                fprintf(stderr, "warning: perf_event_open failed; cycles will be 0\n");
                return;
            }
        }
        ok = true;
    }
    void start() {
        if (!ok) return;
        ioctl(fd[0], PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
        ioctl(fd[0], PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
    }
    void stop(uint64_t& cyc, uint64_t& ref, uint64_t& ins) {
        cyc = ref = ins = 0;
        if (!ok) return;
        ioctl(fd[0], PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
        uint64_t buf[4];
        if (read(fd[0], buf, sizeof(buf)) == (ssize_t)sizeof(buf)) {
            cyc = buf[1];
            ref = buf[2];
            ins = buf[3];
        }
    }
};

struct Measurement {
    double ns;
    uint64_t cycles, ref_cycles, instructions;
};

// Time one call of fn() with both the wall clock and the PMU.
template <class F>
static inline Measurement measure(Counters& c, F&& fn) {
    Measurement m;
    c.start();
    double t0 = now_ns();
    fn();
    double t1 = now_ns();
    c.stop(m.cycles, m.ref_cycles, m.instructions);
    m.ns = t1 - t0;
    return m;
}

static inline void print_header() {
    printf("bench,variant,ws_bytes,param,rep,iters,ns,cycles,ref_cycles,instructions,work,work_unit\n");
}

static inline void print_row(const char* bench, const std::string& variant, uint64_t ws, long param,
                             int rep, uint64_t iters, const Measurement& m, double work,
                             const char* unit) {
    printf("%s,%s,%lu,%ld,%d,%lu,%.0f,%lu,%lu,%lu,%.6g,%s\n", bench, variant.c_str(),
           (unsigned long)ws, param, rep, (unsigned long)iters, m.ns, (unsigned long)m.cycles,
           (unsigned long)m.ref_cycles, (unsigned long)m.instructions, work, unit);
    fflush(stdout);
}

// Page-aligned (or 2 MiB-aligned with transparent huge pages requested)
// buffer, first-touched so page faults do not land in the timed region.
static inline void* alloc_buffer(size_t bytes, bool hugepages) {
    size_t align = hugepages ? (2u << 20) : 4096;
    size_t rounded = (bytes + align - 1) / align * align;
    void* p = aligned_alloc(align, rounded);
    if (!p) {
        perror("aligned_alloc");
        exit(1);
    }
    if (hugepages) madvise(p, rounded, MADV_HUGEPAGE);
    memset(p, 1, rounded);
    return p;
}

// Prevent the compiler from proving a value or memory unused.
template <class T>
static inline void do_not_optimize(T const& v) {
    asm volatile("" : : "r,m"(v) : "memory");
}
static inline void clobber_memory() { asm volatile("" : : : "memory"); }

// Register-only sinks: keep a value live without forcing it to memory.
// (A "m" alternative in do_not_optimize() can make GCC keep a whole
// accumulator array on the stack, adding store-forwarding latency to chains.)
template <class V>
static inline void keep_in_reg_v(V& v) {
    asm volatile("" : "+v"(v));
}
static inline void keep_in_reg_r(uint64_t& v) { asm volatile("" : "+r"(v)); }

static inline long env_long(const char* name, long dflt) {
    const char* v = getenv(name);
    return v ? atol(v) : dflt;
}
