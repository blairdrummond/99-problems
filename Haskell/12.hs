#!/usr/bin/env runhaskell

import Data.List

tris :: [Int]
tris = snd $ mapAccumL (\x y -> (x+y,x+y)) 0 [1..]

primes :: [Int]
primes = 2:filter isPrime [3,5..]
    where
      isPrime p = all (\r-> p `rem` r > 0) $ takeWhile (\q->q*q <= p) primes

p_factors :: Int -> [Int]
p_factors n = filter (\r-> n `rem` r == 0) $ takeWhile (\p->p*p <= n) primes

              
factors :: Num a => Int -> a
factors n = 1 + (product $ map (maximal n 1) (p_factors n))
    where
      maximal x acc m =
          let (q,r) = quotRem x m
          in
            if r == 0
            then maximal q (acc+1) m
            else acc

main :: IO ()
main = print . head $ filter (\x -> factors x > (500::Int)) tris
