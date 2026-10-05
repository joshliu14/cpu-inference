/* Minimal C counterpart of common.h for the compiler-flag kernels. */
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#pragma once
#include <linux/perf_event.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

struct ctr {
    int fd[3];
};
struct meas {
    double ns;
    unsigned long cycles, ref, instr;
};

static inline double now_ns_c(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    return ts.tv_sec * 1e9 + ts.tv_nsec;
}

static inline void ctr_open(struct ctr* c) {
    const uint64_t cfg[3] = {PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_REF_CPU_CYCLES,
                             PERF_COUNT_HW_INSTRUCTIONS};
    for (int i = 0; i < 3; i++) {
        struct perf_event_attr a;
        memset(&a, 0, sizeof(a));
        a.type = PERF_TYPE_HARDWARE;
        a.size = sizeof(a);
        a.config = cfg[i];
        a.disabled = (i == 0);
        a.exclude_hv = 1;
        a.read_format = PERF_FORMAT_GROUP;
        c->fd[i] = (int)syscall(SYS_perf_event_open, &a, 0, -1, i == 0 ? -1 : c->fd[0], 0);
    }
}

static inline void ctr_start(struct ctr* c, struct meas* m) {
    ioctl(c->fd[0], PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
    ioctl(c->fd[0], PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
    m->ns = now_ns_c();
}

static inline void ctr_stop(struct ctr* c, struct meas* m) {
    m->ns = now_ns_c() - m->ns;
    ioctl(c->fd[0], PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
    uint64_t buf[4] = {0};
    if (read(c->fd[0], buf, sizeof(buf)) == (ssize_t)sizeof(buf)) {
        m->cycles = buf[1];
        m->ref = buf[2];
        m->instr = buf[3];
    }
}

static inline long env_long_c(const char* name, long dflt) {
    const char* v = getenv(name);
    return v ? atol(v) : dflt;
}
