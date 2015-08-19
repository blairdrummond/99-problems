#!/usr/bin/env runhaskell

sum_digits :: Integral a => a -> a
sum_digits 0 = 0
sum_digits n = let (q,r) = n `quotRem` 10 in
               r + (sum_digits q)

main :: IO ()
main = print $ sum_digits (2^1000 :: Integer)
