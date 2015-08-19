#!/usr/bin/env runhaskell
{- 
   Find all the factors. If none are found, then n is prime, 
   else take the max
-}

ans :: Integral a => a -> a
ans n = let factors = reverse $ f 2 n [] in
        if factors == []
        then n
        else maximum $ g factors []

{- 
   Find all the factors 
   (need not all be prime, but some are guarenteed to be)
   if the list is empty, then nothing up the the square
   root are factors, making n prime.

-}

f :: Integral a => a -> a -> [a] -> [a]
f x n factors 
    |  n `mod` x == 0  =  if factors /= [] && head factors == x
                          then f x (n `quot` x) factors  -- No repeats
                          else f x (n `quot` x) (x:factors)
    |  n `quot` x < x  = n:factors
    | otherwise        = f (x+1) n factors



{- All factors are in this list, remove those that are composite -}
g :: Integral a => [a] -> [a] -> [a]
g []     acc = acc
g (x:xs) acc = let ys = filter (\y -> y `mod` x /= 0) xs in
               g ys (x:acc) 


main :: IO ()
main = print $ ans (600851475143 :: Integer)
