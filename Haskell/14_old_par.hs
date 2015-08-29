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
    let l = pmap chain [1..n]
        m = maximumBy (comparing snd) l
    in fst $ minimumBy (comparing fst) $ filter (\x -> (snd x) == (snd m)) l


pmap :: (NFData b, NFData a) => (b -> a) -> [b] -> [a]
pmap f l =
    let bs = map f l
        cs = bs `using` parList rdeepseq
    in cs
