#!/usr/bin/env runhaskell
   
import Data.List 

difference :: Int  -> Int
difference n = (sum [1..n])^2 - (foldl' (\ x y -> x + y^2) 0 [1..n])

main :: IO ()
main = print $ difference 100
