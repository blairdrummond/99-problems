#!/usr/bin/env runhaskell

import Data.Char

prodmax :: Int -> [Integer] -> Integer
prodmax len n = maximum $ map product $ lengths len n 

lengths :: Int -> [a] -> [[a]]
lengths len l = [take len $ drop y l | y <- [0.. length l - len]]
 
main :: IO ()
main = do
  n <- readFile "numbers_08.txt"
  print $ prodmax 13 $ map (toInteger . digitToInt) $ filter (/='\n') n
