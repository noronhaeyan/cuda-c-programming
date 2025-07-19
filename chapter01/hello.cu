#include "../common/common.h"
#include <stdio.h>

/*
 * A simple introduction to programming in CUDA. This program prints "Hello
 * World from GPU! from 100 CUDA threads running on the GPU.
 */

__global__ void helloFromGPU()
{
    if (threadIdx.x == 5)
    {
        printf("Hello World from GPU thread %i!\n", threadIdx.x);
    }
}

int main(int argc, char **argv)
{
    printf("Hello World from CPU!\n");

    helloFromGPU<<<1, 10>>>();
    CHECK(cudaDeviceReset());
    return 0;
}