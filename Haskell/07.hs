#!/usr/bin/env runhaskell
   
primes :: [Int]
primes = 2 : filter prime [3,5 .. ]
         where
           factor x y = x `mod` y == 0
           prime x = let candidates = takeWhile (\y -> y*y <= x) primes
                     in not $ any (factor x) candidates 

                        
main :: IO ()
main = print $ primes !! 10000
