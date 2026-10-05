// Plain C kernels compiled several times with different compiler options to
// show what the options change in the generated code and in speed.
//
// The source is identical for every binary; only CFLAGS differ (see Makefile):
//   O2                -O2                          x86-64 baseline ISA (SSE2 only)
//   O3                -O3                          more aggressive vectorizer/unroller
//   O3_native         -O3 -march=native            may use AVX2/AVX-512/FMA for this CPU
//   O3_native_zmm     ... -mprefer-vector-width=512 allow 512-bit auto-vectorization
//   O3_native_fast    ... -ffast-math               allow FP reassociation (reductions)
//
// Kernels:
//   saxpy   y[i] = a * x[i] + y[i]   (vectorizable without changing results)
//   dot     s += x[i] * y[i]         (a reduction: vectorizing it reorders FP
//                                     additions, which -O3 alone may not do)
//   relu    y[i] = x[i] > 0 ? x[i] : 0
// Arrays are sized to stay in L1 so the comparison reflects code generation,
// not memory bandwidth.
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common_c.h"

#ifndef VARIANT
#define VARIANT "unknown"
#endif

__attribute__((noinline)) void saxpy(float* restrict y, const float* restrict x, float a, long n) {
    for (long i = 0; i < n; i++) y[i] = a * x[i] + y[i];
}

__attribute__((noinline)) float dot(const float* restrict x, const float* restrict y, long n) {
    float s = 0.0f;
    for (long i = 0; i < n; i++) s += x[i] * y[i];
    return s;
}

__attribute__((noinline)) void relu(float* restrict y, const float* restrict x, long n) {
    for (long i = 0; i < n; i++) y[i] = x[i] > 0.0f ? x[i] : 0.0f;
}

int main(void) {
    const long n = 2048;                 /* 8 KiB per array: L1 resident */
    const long reps = env_long_c("REPS", 7);
    const long calls = env_long_c("CALLS", 200000);
    float* x = aligned_alloc(64, n * sizeof(float));
    float* y = aligned_alloc(64, n * sizeof(float));
    for (long i = 0; i < n; i++) {
        x[i] = (float)(i % 13) - 6.0f;
        y[i] = 0.001f * (float)i;
    }
    struct ctr c;
    ctr_open(&c);
    printf("bench,variant,ws_bytes,param,rep,iters,ns,cycles,ref_cycles,instructions,work,work_unit\n");
    const char* names[3] = {"saxpy", "dot", "relu"};
    volatile float sink = 0;
    for (int k = 0; k < 3; k++) {
        for (long r = -1; r < reps; r++) {   /* r = -1 is warm-up */
            struct meas m;
            ctr_start(&c, &m);
            for (long i = 0; i < calls; i++) {
                if (k == 0) saxpy(y, x, 1e-6f, n);
                else if (k == 1) sink += dot(x, y, n);
                else relu(y, x, n);
                __asm__ volatile("" ::: "memory");
            }
            ctr_stop(&c, &m);
            if (r >= 0)
                printf("flags,%s:%s,%ld,%ld,%ld,%ld,%.0f,%lu,%lu,%lu,%ld,elements\n", VARIANT, names[k],
                       2 * n * (long)sizeof(float), n, r, calls, m.ns, m.cycles, m.ref, m.instr, calls * n);
        }
    }
    (void)sink;
    return 0;
}
