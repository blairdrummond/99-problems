#!/usr/bin/env runhaskell


import Data.Ord
import Data.List (maximumBy, minimumBy)
import Data.Map.Strict (lookup, fromList, toList, singleton, union, Map, member)
import Data.Maybe

    
collatz :: Integer -> [(Integer, Int)]
collatz n = toList $ collatz' (singleton 1 0) 2 n

            
collatz' :: Map Integer Int -> Integer -> Integer -> Map Integer Int
collatz' m n top
    | not $ n `member` m = collatz' (add_to m n) (n+1) top
    | n == top           = m
    | otherwise          = collatz' m (n+1) top
                        
                      
add_to :: (Enum a, Integral k, Num a) => Map k a -> k -> Map k a
add_to m n = let (end, chain) = take_to (\x -> x `member` m) (iterate next n)
                 end_val = fromJust $ Data.Map.Strict.lookup end m
             in union m $ fromList $ zip (reverse $ init chain) (map (+end_val) [1..])

                 
take_to :: Ord a => (a -> Bool) -> [a] -> (a, [a])
take_to p l = let r = take_to' p l
              in (last r, r)
               
                    
take_to' :: (a -> Bool) -> [a] -> [a]
take_to' _    []  = []
take_to' p (x:xs) = if p x
                    then [x]
                    else x : take_to' p xs


next :: Integral a => a -> a
next m
    | r == 0 = q
    | otherwise = 3*m+1
    where
      (q,r) = quotRem m 2


test2 :: Integer -> Integer
test2 n = let l    = collatz n
              m    = maximumBy (comparing snd) l
              high = filter (\x -> (snd x) == (snd m)) l
              low  = minimumBy (comparing fst) high
          in fst $ low
             

main :: IO () 
main = print $ test2 1000000
