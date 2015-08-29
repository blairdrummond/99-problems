#!/usr/bin/env runhaskell

-- Slow Interpretted. But not too bad compiled...

import Data.Ord
import Data.List
import Control.Parallel.Strategies

chain :: Integral a => a -> (a, Int)
chain n = (n, (length $ takeWhile (>1) $ iterate collatz' n))

collatz' :: Integral a => a -> a
collatz' n
    | r == 0 = q
    | otherwise = 3*n+1
    where
      (q,r) = quotRem n 2


-- Int overflows
main :: IO ()
main = print $ test2 (1000000 :: Integer)

test2 :: (Integral a, NFData a) => a -> a
test2 n =
    let pieces = smallerLists n
        l = concat $ pmap (map $ chain) pieces
        m = maximumBy (comparing snd) l
    in fst $ minimumBy (comparing fst) $ filter (\x -> (snd x) == (snd m)) l


pmap :: (NFData b, NFData a) => (b -> a) -> [b] -> [a]
pmap f l =
    let bs = map f l
        cs = bs `using` parList rdeepseq
    in cs


smallerLists :: Integral a => a -> [[a]]
smallerLists n = foldl mod8 [[],[],[],[],[],[],[],[]] [1..n]
                 where
                   mod8 [a,b,c,d,e,f,g,h] x
                       | r == 0 = [x:a ,  b  ,  c  ,  d  ,  e  ,  f  ,  g  ,  h]
                       | r == 1 = [ a  , x:b ,  c  ,  d  ,  e  ,  f  ,  g  ,  h]
                       | r == 2 = [ a  ,  b  , x:c ,  d  ,  e  ,  f  ,  g  ,  h]
                       | r == 3 = [ a  ,  b  ,  c  , x:d ,  e  ,  f  ,  g  ,  h]
                       | r == 4 = [ a  ,  b  ,  c  ,  d  , x:e ,  f  ,  g  ,  h]
                       | r == 5 = [ a  ,  b  ,  c  ,  d  ,  e  , x:f ,  g  ,  h]
                       | r == 6 = [ a  ,  b  ,  c  ,  d  ,  e  ,  f  , x:g ,  h]
                       | r == 7 = [ a  ,  b  ,  c  ,  d  ,  e  ,  f  ,  g  , x:h]
                       where r = x `rem` 8
