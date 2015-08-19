#!/usr/bin/env runhaskell

three_or_five :: Int -> Int
three_or_five x = sum $ [3,6..x] ++ [5,10..x] ++ [-15, -30 .. -x]

main :: IO ()
main = print $ three_or_five 999
