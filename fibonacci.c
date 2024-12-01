#include <stdio.h>

#define MAX 10

int fib_cache[MAX + 1];

int fibonacci(int n) {
    if (n <= 1) {
        return n;
    }
    if (fib_cache[n] != -1) {
        return fib_cache[n];
    }
    fib_cache[n] = fibonacci(n - 1) + fibonacci(n - 2);
    return fib_cache[n];
}

int main() {
    for (int i = 0; i <= MAX; i++) {
        fib_cache[i] = -1;
    }
    int result = fibonacci(10);
    printf("The 10th term of the Fibonacci sequence is %d\n", result);
    return 0;
}