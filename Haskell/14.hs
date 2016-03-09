#!/usr/bin/env runhaskell

import Data.Ord
import Data.List


chain :: Integral a => a -> (a, Int)
chain n = (n, (length $ takeWhile (>1) $ iterate collatz' n))

collatz' :: Integral a => a -> a
collatz' n
    | r == 0 = q
    | otherwise = 3*n+1
    where
      (q,r) = quotRem n 2

main :: IO ()
main = print $ test2 (1000000 :: Integer)

test2 :: Integral a => a -> a
test2 n =
    let l = map chain [1..n]
        m = maximumBy (comparing snd) l
      in fst $ minimumBy (comparing fst) $ filter (\x -> (snd x) == (snd m)) l
