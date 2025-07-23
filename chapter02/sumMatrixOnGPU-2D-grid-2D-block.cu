#include <cuda_runtime.h> 
#include <stdio.h> 
#include <sys/time.h>

#define CHECK(call)                      \
{                                        \
    const cudaError_t error = call;      \
    if (error != cudaSuccess)            \
    {                                    \
        printf("Error: %s:%d, ",         \
               __FILE__, __LINE__);      \
        printf("code:%d, reason: %s\n",  \
               error, cudaGetErrorString(error)); \
        exit(1);                         \
    }                                    \
}

double cpuSecond() {
    struct timeval tp;
    gettimeofday(&tp,NULL);
    return ((double)tp.tv_sec + (double)tp.tv_usec*1.e-6);
}


int main(int argc, char **argv) { 
    printf("%s Starting...\n", argv[0]);
// set up device
int dev = 0;
cudaDeviceProp deviceProp; 
CHECK(cudaGetDeviceProperties(&deviceProp, dev)); 
printf("Using Device %d: %s\n", dev, deviceProp.name); 
CHECK(cudaSetDevice(dev));
// set up date size of matrix
int nx = 1<<14;
int ny = 1<<14;
int nxy = nx*ny;
int nBytes = nxy * sizeof(float); 
printf("Matrix size: nx %d ny %d\n",nx, ny);
// malloc host memory
float *h_A, *h_B, *hostRef, *gpuRef; 
h_A = (float *)malloc(nBytes);
h_B = (float *)malloc(nBytes); 
hostRef = (float *)malloc(nBytes); 
gpuRef = (float *)malloc(nBytes);
// initialize data at host side
double iStart = cpuSecond(); 
initialData (h_A, nxy); 
initialData (h_B, nxy);
double iElaps = cpuSecond() - iStart;
memset(hostRef, 0, nBytes); 
memset(gpuRef, 0, nBytes);
// add matrix at host side for result checks
iStart = cpuSecond();
sumMatrixOnHost (h_A, h_B, hostRef, nx,ny); 
iElaps = cpuSecond() - iStart;
// malloc device global memory
float *d_MatA, *d_MatB, *d_MatC; 
cudaMalloc((void **)&d_MatA, nBytes); 
cudaMalloc((void **)&d_MatB, nBytes); 
cudaMalloc((void **)&d_MatC, nBytes);
// transfer data from host to device
cudaMemcpy(d_MatA, h_A, nBytes, cudaMemcpyHostToDevice); 
cudaMemcpy(d_MatB, h_B, nBytes, cudaMemcpyHostToDevice);