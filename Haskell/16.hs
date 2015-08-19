#!/usr/bin/env runhaskell

sum_digits :: Integral a => a -> a
sum_digits 0 = 0
sum_digits n = 1 `seq` (r + (sum_digits q))
               where
                 (q,r) = n `quotRem` 10

main :: IO ()
main = print $ sum_digits (2^1000)
