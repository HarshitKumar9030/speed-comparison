public class Benchmark {
    public static boolean isPrime(int n) {
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }

    public static void main(String[] args) {
        long startNano = System.nanoTime();
        int count = 0;
        for (int i = 2; i < 100000; i++) {
            if (isPrime(i)) count++;
        }
        long endNano = System.nanoTime();
        double elapsedSeconds = (endNano - startNano) / 1e9;
        System.out.printf("Java: %.6f seconds%n", elapsedSeconds);
        System.out.println("Prime count: " + count);
    }
}