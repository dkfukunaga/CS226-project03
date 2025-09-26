import math

def get_primes(max):
    sieve = [True] * (max+1)
    sieve[0:2] = [False, False]
    for p in range(2, math.isqrt(max)+1):
        if sieve[p]:
            for multiple in range(p*p, max+1, p):
                sieve[multiple] = False
    return [i for i, is_prime in enumerate(sieve) if is_prime]

def get_prime_factors(num):
    primes = get_primes(math.isqrt(num)+1)
    result = []
    curr_num = num
    for prime in primes:
        if prime * prime > curr_num:
            break
        while curr_num % prime == 0:
            result.append(prime)
            curr_num //= prime
    if curr_num > 1:   # whatever is left must be prime
        result.append(curr_num)
    return result

def maybe_integer_string(s):
    try:
        return int(s)
    except ValueError:
        return None

def main():
    while True:
        test = input(">> ")
        if test.lower() == 'quit' or test.lower() == 'q':
            print("Goodbye! (^.^)")
            break
        test = maybe_integer_string(test)
        if test and test > 1:
            factors = get_prime_factors(test)
            if len(factors) == 1:
                print(f'{test} is prime!')
            else:
                print(f'{test} = {factors[0]}', end='')
                for factor in factors[1:]:
                    print(f' * {factor}', end='')
                print()
        else:
            print("Please enter an integer greater than 1!")

if __name__ == '__main__':
    main()