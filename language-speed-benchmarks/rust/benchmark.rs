use std::time::Instant;

fn is_prime(n: u32) -> bool {
    if n <= 1 {
        return false;
    }
    for i in 2..=(n as f64).sqrt() as u32 {
        if n % i == 0 {
            return false;
        }
    }
    true
}

fn main() {
    let start = Instant::now();
    let mut count = 0;
    for i in 2..100000 {
        if is_prime(i) {
            count += 1;
        }
    }
    let duration = start.elapsed();
    println!("Rust: {:.6} seconds", duration.as_secs_f64());
    println!("Prime count: {}", count);
}