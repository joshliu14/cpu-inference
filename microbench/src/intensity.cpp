// Adjustable arithmetic intensity: the empirical roofline.
//
// Stream through an array of FP32 (working set chosen to live in L1, L2, LLC
// or DRAM). Every loaded 64-byte vector gets F fused multiply-adds applied in
// registers, then is accumulated. Eight vectors are processed together so the
// 8 independent FMA chains cover the FMA latency.
//
//   FLOPs per float  = 2F + 1      (F FMAs + the final add)
//   bytes per float  = 4           (one read; nothing is written)
//   arithmetic intensity AI = (2F + 1) / 4 FLOP/byte
//
// At low F the loop is limited by how fast data arrives (bandwidth roof); at
// high F by FMA throughput (compute roof). Where the curve bends is the
// machine balance point for that level of the hierarchy.
//
// usage: intensity ; env: WS_LIST (comma list of KiB), F_LIST, REPS, THP
#include <immintrin.h>

#include <algorithm>
#include <sstream>
#include <vector>

#include "common.h"

template <int F>
static __attribute__((noinline)) float kernel(const float* a, size_t n, int passes) {
    const __m512 m = _mm512_set1_ps(0.999999f), c = _mm512_set1_ps(1e-7f);
    __m512 acc[8];
    for (int k = 0; k < 8; k++) acc[k] = _mm512_setzero_ps();
    for (int p = 0; p < passes; p++) {
        for (size_t i = 0; i < n; i += 128) {
            __m512 x[8];
#pragma GCC unroll 8
            for (int k = 0; k < 8; k++) x[k] = _mm512_load_ps(a + i + 16 * k);
#pragma GCC unroll 64
            for (int f = 0; f < F; f++) {
#pragma GCC unroll 8
                for (int k = 0; k < 8; k++) x[k] = _mm512_fmadd_ps(x[k], m, c);
            }
#pragma GCC unroll 8
            for (int k = 0; k < 8; k++) acc[k] = _mm512_add_ps(acc[k], x[k]);
        }
        clobber_memory();
    }
    __m512 s = acc[0];
    for (int k = 1; k < 8; k++) s = _mm512_add_ps(s, acc[k]);
    return _mm512_reduce_add_ps(s);
}

typedef float (*KFn)(const float*, size_t, int);
struct FK {
    int F;
    KFn fn;
};
static const FK KERNELS[] = {{0, kernel<0>},   {1, kernel<1>},   {2, kernel<2>},   {4, kernel<4>},
                             {8, kernel<8>},   {16, kernel<16>}, {32, kernel<32>}, {64, kernel<64>}};

static std::vector<long> parse_list(const char* s, std::vector<long> dflt) {
    if (!s) return dflt;
    std::vector<long> v;
    std::stringstream ss(s);
    std::string tok;
    while (std::getline(ss, tok, ',')) v.push_back(atol(tok.c_str()));
    return v;
}

int main() {
    const int reps = (int)env_long("REPS", 5);
    const bool thp = env_long("THP", 0) != 0;
    // Default working sets (KiB): L1-, L2-, LLC- and DRAM-resident on this CPU
    // (48 KiB L1D, 2 MiB L2, 52.5 MiB shared L3).
    auto ws_list = parse_list(getenv("WS_LIST"), {24, 1024, 16384, 524288});
    auto f_list = parse_list(getenv("F_LIST"), {0, 1, 2, 4, 8, 16, 32, 64});
    const double min_flops_bytes = 4e8;
    Counters ctr;
    print_header();
    for (long ws_kib : ws_list) {
        size_t bytes = (size_t)ws_kib << 10;
        size_t n = bytes / 4 / 128 * 128;
        float* a = (float*)alloc_buffer(n * 4, thp);
        for (size_t i = 0; i < n; i++) a[i] = 1.0f;
        for (long F : f_list) {
            const FK* k = nullptr;
            for (auto& kk : KERNELS)
                if (kk.F == F) k = &kk;
            if (!k) continue;
            // Enough passes for >= ~0.2 s at the slower of the two roofs.
            double work_per_pass = (double)n * 4 * (1 + F / 4.0);
            int passes = (int)std::max(1.0, min_flops_bytes / work_per_pass);
            do_not_optimize(k->fn(a, n, 1));
            for (int r = 0; r < reps; r++) {
                float out = 0;
                Measurement m = measure(ctr, [&] { out = k->fn(a, n, passes); });
                do_not_optimize(out);
                double flops = (double)n * passes * (2.0 * F + 1);
                print_row("intensity", "avx512_F" + std::to_string(F), n * 4, F, r, passes, m, flops,
                          "flops");
            }
        }
        free(a);
    }
    return 0;
}
