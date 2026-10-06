// Register-only arithmetic: latency vs throughput of scalar and SIMD units.
//
// Each kernel runs K independent dependency chains. With K = 1 every
// instruction waits for the previous result, so time/op = instruction
// LATENCY. As K grows, independent chains overlap in the pipeline until the
// execution ports saturate, so time/op approaches 1/THROUGHPUT. The K at which
// it saturates is latency x throughput (Little's law for the pipeline).
//
// Instructions are emitted with inline asm so that the compiler cannot fold,
// reorder, vectorize or delete them: each asm statement is exactly one
// instruction of the named kind (verify with objdump; see the run script).
// No memory is touched inside the timed loops.
#include <immintrin.h>

#include <vector>

#include "common.h"

#define REP8(x) x x x x x x x x
// Fully unroll the loop over chains so every accumulator lives in its own
// register (verified in the objdump listing: no memory operands in the loop).
#define FOR_K _Pragma("GCC unroll 16") for (int k = 0; k < K; k++)

template <int K>
static void int_add(uint64_t iters) {
    uint64_t acc[K];
    FOR_K acc[k] = k;
    const uint64_t c = 3;
    for (uint64_t i = 0; i < iters; i++) {
        REP8(FOR_K asm volatile("add %1, %0" : "+r"(acc[k]) : "r"(c));)
    }
    FOR_K keep_in_reg_r(acc[k]);
}

template <int K>
static void int_imul(uint64_t iters) {
    uint64_t acc[K];
    FOR_K acc[k] = k + 1;
    const uint64_t c = 3;
    for (uint64_t i = 0; i < iters; i++) {
        REP8(FOR_K asm volatile("imul %1, %0" : "+r"(acc[k]) : "r"(c));)
    }
    FOR_K keep_in_reg_r(acc[k]);
}

// FP kernels: acc = acc * a + b (FMA) or acc = acc + b / acc * a (ADD/MUL).
// a = 1 and b tiny keep values normal (no denormal slow paths, no overflow).
#define FP_KERNEL(NAME, VT, SET1, ASM)                                         \
    template <int K>                                                           \
    static void NAME(uint64_t iters) {                                         \
        VT acc[K];                                                             \
        FOR_K acc[k] = SET1(1.0f);                                             \
        VT a = SET1(1.0f), b = SET1(1e-7f);                                   \
        for (uint64_t i = 0; i < iters; i++) {                                 \
            REP8(FOR_K asm volatile(ASM : "+v"(acc[k]) : "v"(a), "v"(b));) \
        }                                                                      \
        FOR_K keep_in_reg_v(acc[k]);                                           \
    }

static inline __m128 set1_ss(float f) { return _mm_set_ss(f); }

FP_KERNEL(fp32_scalar_add, __m128, set1_ss, "vaddss %2, %0, %0")
FP_KERNEL(fp32_scalar_mul, __m128, set1_ss, "vmulss %1, %0, %0")
FP_KERNEL(fp32_scalar_fma, __m128, set1_ss, "vfmadd231ss %1, %2, %0")
FP_KERNEL(fp32_sse_fma, __m128, _mm_set1_ps, "vfmadd231ps %1, %2, %0")
FP_KERNEL(fp32_avx2_fma, __m256, _mm256_set1_ps, "vfmadd231ps %1, %2, %0")
FP_KERNEL(fp32_avx512_fma, __m512, _mm512_set1_ps, "vfmadd231ps %1, %2, %0")
FP_KERNEL(fp32_avx512_add, __m512, _mm512_set1_ps, "vaddps %2, %0, %0")
FP_KERNEL(fp32_avx512_mul, __m512, _mm512_set1_ps, "vmulps %1, %0, %0")
// max: the operation behind ReLU (max(x, 0)) and max-pooling.
FP_KERNEL(fp32_scalar_max, __m128, set1_ss, "vmaxss %2, %0, %0")
FP_KERNEL(fp32_avx2_max, __m256, _mm256_set1_ps, "vmaxps %2, %0, %0")
FP_KERNEL(fp32_avx512_max, __m512, _mm512_set1_ps, "vmaxps %2, %0, %0")

struct Variant {
    const char* name;
    int width;          // FP32 lanes (1 for scalar / integer)
    int flops_per_op;   // 2 for FMA, 1 for add/mul, 0 for integer
    void (*fn[8])(uint64_t);
};

#define KS(F) {F<1>, F<2>, F<4>, F<6>, F<8>, F<10>, F<12>, F<16>}
// 16 integer accumulators + the constant exceed the 15 usable GPRs and would
// spill to the stack, so integer kernels stop at K = 12.
#define KS_INT(F) {F<1>, F<2>, F<4>, F<6>, F<8>, F<10>, F<12>, nullptr}
static const int K_VALUES[8] = {1, 2, 4, 6, 8, 10, 12, 16};

int main() {
    const int reps = (int)env_long("REPS", 7);
    const uint64_t target_ops = (uint64_t)env_long("TARGET_OPS", 200000000);
    Variant vs[] = {
        {"int_add", 1, 0, KS_INT(int_add)},
        {"int_imul", 1, 0, KS_INT(int_imul)},
        {"fp32_scalar_add", 1, 1, KS(fp32_scalar_add)},
        {"fp32_scalar_mul", 1, 1, KS(fp32_scalar_mul)},
        {"fp32_scalar_fma", 1, 2, KS(fp32_scalar_fma)},
        {"fp32_sse_fma", 4, 2, KS(fp32_sse_fma)},
        {"fp32_avx2_fma", 8, 2, KS(fp32_avx2_fma)},
        {"fp32_avx512_add", 16, 1, KS(fp32_avx512_add)},
        {"fp32_avx512_mul", 16, 1, KS(fp32_avx512_mul)},
        {"fp32_avx512_fma", 16, 2, KS(fp32_avx512_fma)},
        {"fp32_scalar_max", 1, 1, KS(fp32_scalar_max)},
        {"fp32_avx2_max", 8, 1, KS(fp32_avx2_max)},
        {"fp32_avx512_max", 16, 1, KS(fp32_avx512_max)},
    };
    Counters ctr;
    print_header();
    const char* only = getenv("ONLY_VARIANT");   // e.g. fp32_avx512_fma
    const long only_k = env_long("ONLY_K", 0);
    for (auto& v : vs) {
        if (only && std::string(only) != v.name) continue;
        for (int ki = 0; ki < 8; ki++) {
            if (!v.fn[ki]) continue;
            int K = K_VALUES[ki];
            if (only_k && only_k != K) continue;
            uint64_t iters = target_ops / (8 * K);
            uint64_t ops = iters * 8 * K;
            v.fn[ki](iters / 10);  // warm-up (also lets AVX-512 power license settle)
            for (int r = 0; r < reps; r++) {
                Measurement m = measure(ctr, [&] { v.fn[ki](iters); });
                // work = instructions of the named kind; analysis derives FLOPs.
                print_row("compute", v.name, 0, K, r, iters, m, (double)ops, "ops");
            }
        }
    }
    return 0;
}
