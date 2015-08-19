#!/usr/bin/env runhaskell
   
main :: IO ()
main = print . maximum $ filter
       (\x -> show x == (reverse $ show x))
       [ x*y | x <-[ (100 :: Int) .. 999], y <-[100..999]]
