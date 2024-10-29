function isPrime(n) {
    for (let i = 2; i * i <= n; i++) {
        if (n % i === 0) return false;
    }
    return true;
}

const start = Date.now();
let count = 0;
for (let i = 2; i < 100000; i++) {
    if (isPrime(i)) count++;
}
const end = Date.now();
console.log(`JavaScript: ${(end - start) / 1000} seconds`);
