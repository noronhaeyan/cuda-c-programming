# Makefile to compile all .c and .cu files

# Compiler definitions
CC = gcc
NVCC = nvcc

# Compiler flags
CFLAGS = -O2
NVFLAGS = -O2

# Find source files
C_SRC := $(wildcard *.c)
CU_SRC := $(wildcard *.cu)

# Define output executables
C_OBJS := $(C_SRC:.c=)
CU_OBJS := $(CU_SRC:.cu=)

# Default target
all: $(C_OBJS) $(CU_OBJS)

# Rules for compiling C programs
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# Rules for compiling CUDA programs
%: %.cu
	$(NVCC) $(NVFLAGS) $< -o $@

# Clean rule
clean:
	rm -f $(C_OBJS) $(CU_OBJS)
