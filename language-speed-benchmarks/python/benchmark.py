import time

def is_prime(n):
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

start = time.time()
count = sum(1 for i in range(2, 100000) if is_prime(i))
end = time.time()
print(f"Python: {end - start} seconds")
