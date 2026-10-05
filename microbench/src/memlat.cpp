// Load-to-use latency vs working-set size (pointer chasing).
//
// The buffer is split into 64-byte nodes (one cache line each). Each node
// holds a pointer to the next node, and the chain visits every node exactly
// once before repeating. Because every load's ADDRESS comes from the previous
// load's DATA, loads cannot overlap: time per step = full latency of
// whichever level of the hierarchy holds the line.
//
// Patterns:
//   random      single random cycle (Sattolo). Defeats the hardware prefetchers.
//   sequential  node i -> node i+1. Same dependent chain, but the address
//               stream is predictable, so the prefetchers can hide latency.
// Page size: THP=1 requests 2 MiB pages (madvise), separating cache latency
// from TLB-miss (page walk) cost at large working sets.
//
// usage: memlat [random|sequential] ; env: THP=0/1, MIN_KB, MAX_MB, REPS
#include <algorithm>
#include <cmath>
#include <random>
#include <vector>

#include "common.h"

struct Node {
    Node* next;
    char pad[64 - sizeof(Node*)];
};

static Node* build_chain(Node* nodes, size_t n, bool random, std::mt19937_64& rng) {
    std::vector<size_t> order(n);
    for (size_t i = 0; i < n; i++) order[i] = i;
    if (random) {
        // Sattolo's algorithm: a uniformly random permutation that is one cycle.
        for (size_t i = n - 1; i > 0; i--) {
            std::uniform_int_distribution<size_t> d(0, i - 1);
            std::swap(order[i], order[d(rng)]);
        }
    }
    for (size_t i = 0; i < n; i++) nodes[order[i]].next = &nodes[order[(i + 1) % n]];
    return &nodes[order[0]];
}

static __attribute__((noinline)) Node* chase(Node* p, uint64_t steps) {
    for (uint64_t i = 0; i < steps; i += 8) {
        p = p->next; p = p->next; p = p->next; p = p->next;
        p = p->next; p = p->next; p = p->next; p = p->next;
    }
    return p;
}

int main(int argc, char** argv) {
    const bool random = !(argc > 1 && std::string(argv[1]) == "sequential");
    const bool thp = env_long("THP", 0) != 0;
    const int reps = (int)env_long("REPS", 5);
    const size_t min_bytes = (size_t)env_long("MIN_KB", 4) << 10;
    const size_t max_bytes = (size_t)env_long("MAX_MB", 1024) << 20;
    const uint64_t max_steps = (uint64_t)env_long("MAX_STEPS", 8000000);
    std::mt19937_64 rng(42);
    Counters ctr;
    print_header();
    std::string variant = std::string(random ? "random" : "sequential") + (thp ? "_thp" : "_4k");

    // Working sets from MIN to MAX in steps of 2^(1/4) (four points per octave).
    for (double e = std::log2((double)min_bytes); e <= std::log2((double)max_bytes) + 1e-9; e += 0.25) {
        size_t ws = (size_t)std::llround(std::pow(2.0, e)) / 64 * 64;
        size_t n = ws / sizeof(Node);
        Node* nodes = (Node*)alloc_buffer(ws, thp);
        Node* head = build_chain(nodes, n, random, rng);
        // Steps: at least 4 laps for cache-resident sets (steady state), capped
        // for DRAM-sized sets where every step is a miss anyway.
        uint64_t steps = std::max<uint64_t>(std::min<uint64_t>(4 * n, max_steps), 1000000);
        steps = (steps + 7) / 8 * 8;
        // Warm-up: two full laps (bounded) so the measured laps see steady state.
        head = chase(head, std::min<uint64_t>(2 * n + 8, max_steps) / 8 * 8 + 8);
        for (int r = 0; r < reps; r++) {
            Measurement m = measure(ctr, [&] { head = chase(head, steps); });
            print_row("memlat", variant, ws, 0, r, steps, m, (double)steps, "loads");
        }
        do_not_optimize(head);
        free(nodes);
    }
    return 0;
}
