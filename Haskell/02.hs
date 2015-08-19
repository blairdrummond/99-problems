#!/usr/bin/env runhaskell
import Data.List

fibs :: [Integer]
fibs = 1:1:zipWith (+) fibs (tail fibs) 

main :: IO ()
main = print $ foldl1' (+) $ filter even $ takeWhile (<=4000000) fibs
