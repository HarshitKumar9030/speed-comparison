#include <stdio.h>
#include <stdbool.h>
#include <time.h>

bool is_prime(int n) {
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int main() {
    clock_t start = clock();
    int count = 0;
    for (int i = 2; i < 100000; i++) {
        if (is_prime(i)) count++;
    }
    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("C: %f seconds\n", time_spent);
    return 0;
}
