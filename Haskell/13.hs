#!/usr/bin/env runhaskell

import System.IO
import Control.Monad
import Data.List
import Data.Char

    
main :: IO ()
main =  do
  text  <- (readFile "numbers_13.txt")
  first <- return $ map (take 10) $ lines text
  ints  <- return $ map (\x-> read x :: Integer) $ lines text
  print $ largest_10 (foldl1' (+) ints)
         where
           printl []     = print ""
           printl (x:xs) = do print x
                              printl xs
           largest_10 x  = let size = ceiling $ logBase 10 $ fromInteger x
                           in x `quot` (10^(size - 10)) 
