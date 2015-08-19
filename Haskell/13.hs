#!/usr/bin/env runhaskell

main :: IO ()
main =  do
  text  <- (readFile "numbers_13.txt")
  ints  <- return $ map (\x-> read x :: Integer) $ lines text
  print . largest_10 . sum $ ints
         where
           largest_10 x  = let size = ceiling $ logBase 10 $ fromInteger x
                           in x `quot` (10^(size - 10)) 
