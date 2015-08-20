#!/usr/bin/env runhaskell
   
primes :: [Integer]
primes = 2:filter isPrime [3,5..]
    where
      isPrime p = all (\q -> p `rem` q /= 0) $ takeWhile (\q -> q*q <= p) primes
                      
main :: IO ()
main = print . sum $ takeWhile (<2000000) primes
