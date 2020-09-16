#include <iostream>
#include <cmath>

/*
 * Truncatable Primes
 * Lexxi Reddington
 */

// Function Declarations
bool is_prime(int x);
bool is_left_truncatable(int x);
int build_truncatable_primes(int start);

int main() {
    std::cout << "The truncatable primes are: " << std::endl;
    build_truncatable_primes(2);
    build_truncatable_primes(3);
    build_truncatable_primes(5);
    build_truncatable_primes(7);
    return 0;
}

// Function Definitions
// Function to determine if a number is prime or not
// OPTIMIZED to reflect class discussion on Oct. 17
bool is_prime(int x) {
    // Tricky: 1 is NOT prime
    if (x < 2) {
        return false;
    }
    if (x == 2 || x == 3) {
        return true;
    }
    if (x % 2 == 0 || x % 3 == 0) {
        return false;
    }
    // Check for divisors
    int sqrt = static_cast<int>(std::sqrt(x));
    for(int i = 5; i <= sqrt; i += 6) {
        if((x % i == 0) || (x % (i + 2) == 0)) {
            return false;
        }
    }
    return true;
}

// Function to determine if a number is left-truncatable
bool is_left_truncatable(int x) {
    // Find the first power of ten that is larger than input x
    // x % power_of_ten (do this from largest power to smallest to peel off each digit in x from left to right
    int power_of_ten = 1;
    while (power_of_ten < x) {
        power_of_ten *= 10;
    } // At this point we have a power of ten that is larger than x

    // "Peel off" subsequent digits of x from left to right and check if they're prime
    while(x > 0) {
        if (is_prime(x) == false) {
            return false;
        }
        power_of_ten /= 10;
        if (x < power_of_ten) {
            return false;
        }
        x %= power_of_ten; // Chop off the left-most digit of x to get the new x
    }
    return true;
}

// Function to build (left and right) truncatable primes
int build_truncatable_primes(int start) {
    if (!(is_prime(start))) {
        return 0;
    }
    if (is_left_truncatable(start)) {
        std::cout << start << std::endl;
    }
    build_truncatable_primes(start * 10 + 1);
    build_truncatable_primes(start * 10 + 3);
    build_truncatable_primes(start * 10 + 7);
    build_truncatable_primes(start * 10 + 9);
}