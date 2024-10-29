#include <iostream>
#include <cmath>
#include <chrono>

bool is_prime(int n) {
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();
    int count = 0;
    for (int i = 2; i < 100000; i++) {
        if (is_prime(i)) count++;
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;
    std::cout << "C++: " << diff.count() << " seconds" << std::endl;
    return 0;
}
