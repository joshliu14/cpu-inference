// Single-core bandwidth vs working-set size.
//
// Kernels (AVX-512, 64-byte vectors, several independent accumulators so the
// loop is limited by the memory system rather than by add latency):
//   read      sum += a[i]                       (bytes counted: reads)
//   write     a[i] = v                          (regular stores: line is first
//                                                read-for-ownership, then written)
//   write_nt  a[i] = v with non-temporal stores (bypass caches, no RFO)
//   copy      b[i] = a[i]
//   triad     a[i] = b[i] + s * c[i]            (STREAM triad: 2 reads, 1 write)
//   rand_read sum += a[idx[j]] for random line indices (independent loads, so
//             many misses can be in flight: contrast with pointer chasing)
// Reported bytes are the bytes the program asks for (STREAM convention);
// RFO traffic for regular stores is NOT added, which is documented.
//
// usage: membw <kernel>; env: THP, MIN_KB, MAX_MB, REPS, MIN_BYTES_PER_REP
#include <immintrin.h>

#include <algorithm>
#include <cmath>
#include <random>
#include <vector>

#include "common.h"

static __attribute__((noinline)) float k_read(const float* a, size_t n, int passes) {
    __m512 s0 = _mm512_setzero_ps(), s1 = s0, s2 = s0, s3 = s0, s4 = s0, s5 = s0, s6 = s0, s7 = s0;
    for (int p = 0; p < passes; p++) {
        for (size_t i = 0; i < n; i += 128) {
            s0 = _mm512_add_ps(s0, _mm512_load_ps(a + i));
            s1 = _mm512_add_ps(s1, _mm512_load_ps(a + i + 16));
            s2 = _mm512_add_ps(s2, _mm512_load_ps(a + i + 32));
            s3 = _mm512_add_ps(s3, _mm512_load_ps(a + i + 48));
            s4 = _mm512_add_ps(s4, _mm512_load_ps(a + i + 64));
            s5 = _mm512_add_ps(s5, _mm512_load_ps(a + i + 80));
            s6 = _mm512_add_ps(s6, _mm512_load_ps(a + i + 96));
            s7 = _mm512_add_ps(s7, _mm512_load_ps(a + i + 112));
        }
        clobber_memory();
    }
    __m512 s = _mm512_add_ps(_mm512_add_ps(_mm512_add_ps(s0, s1), _mm512_add_ps(s2, s3)),
                             _mm512_add_ps(_mm512_add_ps(s4, s5), _mm512_add_ps(s6, s7)));
    return _mm512_reduce_add_ps(s);
}

static __attribute__((noinline)) void k_write(float* a, size_t n, int passes) {
    for (int p = 0; p < passes; p++) {
        __m512 v = _mm512_set1_ps((float)p);
        for (size_t i = 0; i < n; i += 64) {
            _mm512_store_ps(a + i, v);
            _mm512_store_ps(a + i + 16, v);
            _mm512_store_ps(a + i + 32, v);
            _mm512_store_ps(a + i + 48, v);
        }
        clobber_memory();
    }
}

static __attribute__((noinline)) void k_write_nt(float* a, size_t n, int passes) {
    for (int p = 0; p < passes; p++) {
        __m512 v = _mm512_set1_ps((float)p);
        for (size_t i = 0; i < n; i += 64) {
            _mm512_stream_ps(a + i, v);
            _mm512_stream_ps(a + i + 16, v);
            _mm512_stream_ps(a + i + 32, v);
            _mm512_stream_ps(a + i + 48, v);
        }
        _mm_sfence();
        clobber_memory();
    }
}

static __attribute__((noinline)) void k_copy(const float* a, float* b, size_t n, int passes) {
    for (int p = 0; p < passes; p++) {
        for (size_t i = 0; i < n; i += 64) {
            _mm512_store_ps(b + i, _mm512_load_ps(a + i));
            _mm512_store_ps(b + i + 16, _mm512_load_ps(a + i + 16));
            _mm512_store_ps(b + i + 32, _mm512_load_ps(a + i + 32));
            _mm512_store_ps(b + i + 48, _mm512_load_ps(a + i + 48));
        }
        clobber_memory();
    }
}

static __attribute__((noinline)) void k_triad(float* a, const float* b, const float* c, size_t n,
                                              int passes) {
    const __m512 s = _mm512_set1_ps(0.5f);
    for (int p = 0; p < passes; p++) {
        for (size_t i = 0; i < n; i += 32) {
            _mm512_store_ps(a + i, _mm512_fmadd_ps(s, _mm512_load_ps(c + i), _mm512_load_ps(b + i)));
            _mm512_store_ps(a + i + 16,
                            _mm512_fmadd_ps(s, _mm512_load_ps(c + i + 16), _mm512_load_ps(b + i + 16)));
        }
        clobber_memory();
    }
}

// One 4-byte load per random cache line; indices are precomputed and read
// sequentially, so the random loads are independent of each other.
static __attribute__((noinline)) float k_rand_read(const float* a, const uint32_t* idx, size_t m,
                                                   int passes) {
    float s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    for (int p = 0; p < passes; p++) {
        for (size_t j = 0; j < m; j += 4) {
            s0 += a[idx[j]];
            s1 += a[idx[j + 1]];
            s2 += a[idx[j + 2]];
            s3 += a[idx[j + 3]];
        }
        clobber_memory();
    }
    return s0 + s1 + s2 + s3;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: membw read|write|write_nt|copy|triad|rand_read\n");
        return 1;
    }
    const std::string kernel = argv[1];
    const bool thp = env_long("THP", 0) != 0;
    const int reps = (int)env_long("REPS", 5);
    const size_t min_bytes = (size_t)env_long("MIN_KB", 4) << 10;
    const size_t max_bytes = (size_t)env_long("MAX_MB", 1024) << 20;
    const double min_bytes_per_rep = (double)env_long("MIN_BYTES_PER_REP", 400000000);
    Counters ctr;
    print_header();
    std::mt19937_64 rng(7);

    // ws = total footprint of all arrays the kernel touches.
    const int narrays = kernel == "copy" ? 2 : kernel == "triad" ? 3 : 1;
    for (double e = std::log2((double)min_bytes); e <= std::log2((double)max_bytes) + 1e-9; e += 0.5) {
        size_t ws = (size_t)std::llround(std::pow(2.0, e));
        size_t per = std::max<size_t>(ws / narrays / 512 * 512, 512);   // bytes per array
        size_t n = per / sizeof(float);
        float* a = (float*)alloc_buffer(per, thp);
        float* b = narrays > 1 ? (float*)alloc_buffer(per, thp) : nullptr;
        float* c = narrays > 2 ? (float*)alloc_buffer(per, thp) : nullptr;
        size_t total = per * narrays;
        std::vector<uint32_t> idx;
        size_t lines = per / 64;
        if (kernel == "rand_read") {
            size_t m = std::max<size_t>(std::min<size_t>(lines, 1 << 22), 4096) / 4 * 4;
            idx.resize(m);
            std::uniform_int_distribution<uint32_t> d(0, (uint32_t)lines - 1);
            for (auto& x : idx) x = d(rng) * 16;   // float index of a line start
        }
        double bytes_per_pass = kernel == "rand_read" ? 64.0 * idx.size() : (double)total;
        int passes = (int)std::max(1.0, std::ceil(min_bytes_per_rep / bytes_per_pass));
        auto run = [&] {
            if (kernel == "read") do_not_optimize(k_read(a, n, passes));
            else if (kernel == "write") k_write(a, n, passes);
            else if (kernel == "write_nt") k_write_nt(a, n, passes);
            else if (kernel == "copy") k_copy(a, b, n, passes);
            else if (kernel == "triad") k_triad(a, b, c, n, passes);
            else if (kernel == "rand_read") do_not_optimize(k_rand_read(a, idx.data(), idx.size(), passes));
        };
        int saved = passes;
        passes = 1;
        run();   // warm-up: one pass brings the working set into the caches
        passes = saved;
        for (int r = 0; r < reps; r++) {
            Measurement m = measure(ctr, run);
            // work = bytes requested by the program (lines touched x 64 for rand_read)
            print_row("membw", kernel + (thp ? "_thp" : "_4k"), total, passes, r, passes, m,
                      bytes_per_pass * passes, "bytes");
        }
        free(a);
        if (b) free(b);
        if (c) free(c);
    }
    return 0;
}
