#include <stdio.h>
#include <math.h>

double pi_nth_digit(int n) {
    double pi = 0.0;
    for (int k = 0; k <= n; k++) {
        pi += (1.0 / pow(16, k)) * 
              (4.0 / (8 * k + 1) - 
               2.0 / (8 * k + 4) - 
               1.0 / (8 * k + 5) - 
               1.0 / (8 * k + 6));
    }
    return pi;
}

int main() {
    int n;
    printf("Enter the number of decimal places to calculate Pi: ");
    scanf("%d", &n);

    if (n < 0) {
        printf("Number of decimal places must be non-negative.\n");
        return 1;
    }

    double pi = pi_nth_digit(n);
    printf("Pi up to %d decimal places is: %.*f\n", n, n, pi);
    int nth_digit = (pi * pow(10, n));
    printf("nth_digit: %d\n", nth_digit);
    nth_digit = (int) nth_digit % 10;
    printf("The %d-th digit of Pi is: %d\n", n, nth_digit);
    // printf("Pi up to %d decimal places is: %.*f\n", n, n, pi);

    return 0;
}