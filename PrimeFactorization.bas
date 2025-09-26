10 REM PrimeFactorization program
11 REM Continuously prompt user for a number to factor.
12 REM If they enter sometheing that is not a positive integer, displays
13 REM an error message and prompts again. If they enter 'Q' quits.
14 REM Uses Sieve of Eratosthenes to calculate a list of primes up to
15 REM the square root of the given number and then uses that list of primes
16 REM to find all the prime factors of the number. If the number is prime,
17 REM aka the list only contains itself, tell the user that is is prime.
18 REM Otherwise, display the factors in the form "N = f1 * f2 * ... * fn".

50 CLEAR : REM clear all variables and arrays
51 REM this version of BASIC doesn't allow resizing arrays

59 REM Utility function
60 DEF FN ISQR(X) = INT(SQR(X)) : REM returns integer square root

90 HOME : REM Program prompt
100 PRINT "Enter a positive integer or Q to quit"
120 INPUT ">> "; IN$
130 IF IN$ = "Q" GOTO 6000
140 N = VAL(IN$) : IF N < 1 THEN GOSUB 5500 : GOTO 90 : REM error message
150 IF N = 1 THEN PRINT "1 is neither prime nor composite." : GOSUB 5600 : GOTO 90 : REM pause
160 GOSUB 1000 : REM GetFactors(N) -> AF(), LF
170 IF LF = 1 THEN PRINT N; " IS PRIME!" : GOSUB 5600 : GOTO 50 : REM pause
180 PRINT N; " = "; AF(0);
190 FOR I = 1 TO LF-1 : PRINT " * "; AF(I); : NEXT I : PRINT
200 GOSUB 5600 : GOTO 50 : REM pause
201 REM Program loop

1000 REM GetFactors(N) -> AF(), LF
1001 REM calculates all the prime factors of N, including multiples
1002 REM returns array of factors AF(), length of array LF
1010 MF = INT(LOG(N)/LOG(2)) : REM max number of prime factors (with multiplicity)
1030 MP = FN ISQR(N) : IF MP < 2 THEN MP = 2 : REM calc largest possible factor
1040 GOSUB 2000 : REM GetPrimes(MP) -> PR(MP), LP
1100 CN = N
1110 FOR I = 0 TO LP-1 : REM iterate through list of primes
1120 P = PR(I)
1130 IF P*P > CN GOTO 1180 : REM skip primes that are too big
1140 IF CN - INT(CN/P)*P <> 0 GOTO 1180 : REM check if prime divides into CN
1150 AF(LF) = P : LF = LF + 1 : REM add to list
1160 CN = CN / P
1170 GOTO 1140 : REM keep looping to find all factors of the same prime number
1180 NEXT I
1190 IF CN > 1 THEN AF(LF) = CN : LF = LF + 1 : REM if CN > 1 then it is a factor
1200 RETURN : REM GetFactors

2000 REM GetPrimes(MP) -> PR(MP), LP
2001 REM calculates prime numbers up to MP using the Sieve of Eratosthenes
2002 REM returns array PR of prime numbers, length of array LP
2010 DIM S(MP), PR(MP) : REM boolean sieve S(), and prime list PR()
2020 FOR I = 0 TO MP : S(I) = -1 : NEXT I  : REM -1 TRUE (I is prime), 0 FALSE (I is composite)
2030 S(0) = 0 : S(1) = 0 : REM 0 and 1 are never prime
2035 LMT = FN ISQR(MP) : REM sieve only needs to go through the square root of MP
2040 FOR P = 2 TO LMT
2050 IF S(P) = 0 GOTO 2100 : REM skip numbers already removed
2062 K = P*P : IF K > MP GOTO 2100 : REM out of bounds check
2070 FOR J = K TO MP STEP P : REM the sieve itself
2080 S(J) = 0
2090 NEXT J : REM end of the sieve
2100 NEXT P : REM continue iterating through the sieve
2110 LP = 0 : REM count primes (LP)
2120 FOR I = 2 TO MP : REM loop through sieve to create array of primes
2130 IF S(I) THEN PR(LP) = I : LP = LP + 1
2140 NEXT I
2150 RETURN : REM GetPrimes

5500 REM error message
5510 PRINT "Please enter a positive integer!"
5520 GOSUB 5600 : REM pause
5530 RETURN : REM error message

5600 REM pause
5610 PRINT "Press any key";
5620 GET X$ : PRINT
5630 RETURN : REM pause

6000 REM exit program
6010 PRINT "Goodbye! (^.^)"
6020 END : REM exit program