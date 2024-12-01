#include <stdio.h>
#include <time.h>

int main() {
    unsigned long long a = 0, b = 1, c;
    time_t start, end;
    int term = 1;  // Counter for the term of the Fibonacci sequence
    
    time(&start);
    while (1) {
        c = a + b;
        a = b;
        b = c;
        term++;  // Increment the term counter
        
        time(&end);
        if (difftime(end, start) >= 1.0) {
            break;
        }
    }
    
    printf("Largest Fibonacci number in 1 second: %llu (Term: %d)\n", a, term);
    return 0;
}