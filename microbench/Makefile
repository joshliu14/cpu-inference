# Native microbenchmarks.
#
#   make                    build everything with the default flags
#   make OPT="-O3"          override optimisation level for the intrinsic benchmarks
#   make asm                write objdump listings of the hot kernels to bin/*.asm
#
# The intrinsic/asm benchmarks need AVX-512 code generation, so they are
# always built with -march=native; OPT controls the optimisation level.
# flags_kernels.c is built five times with different options (see FLAG_VARIANTS)
# to compare what the compiler does with the same source.

CXX      ?= g++
CC       ?= gcc
OPT      ?= -O2
ARCH     ?= -march=native
CXXFLAGS ?= $(OPT) $(ARCH) -std=c++17 -Wall -Wextra -g
BIN      := bin

MAIN := compute memlat membw intensity
FLAG_VARIANTS := O2 O3 O3_native O3_native_zmm O3_native_fast

FLAGS_O2             := -O2
FLAGS_O3             := -O3
FLAGS_O3_native      := -O3 -march=native
FLAGS_O3_native_zmm  := -O3 -march=native -mprefer-vector-width=512
FLAGS_O3_native_fast := -O3 -march=native -mprefer-vector-width=512 -ffast-math

all: $(addprefix $(BIN)/,$(MAIN)) $(addprefix $(BIN)/flags_,$(FLAG_VARIANTS))

$(BIN):
	mkdir -p $(BIN)

$(BIN)/%: src/%.cpp src/common.h | $(BIN)
	$(CXX) $(CXXFLAGS) -o $@ $<

$(BIN)/flags_%: src/flags_kernels.c src/common_c.h | $(BIN)
	$(CC) $(FLAGS_$*) -g -std=c11 -DVARIANT=\"$*\" -o $@ $<

asm: all
	for b in $(MAIN) $(addprefix flags_,$(FLAG_VARIANTS)); do \
		objdump -d -M intel --no-show-raw-insn -C $(BIN)/$$b > $(BIN)/$$b.asm; done

clean:
	rm -rf $(BIN)

.PHONY: all asm clean
