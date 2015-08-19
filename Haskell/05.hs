#!/usr/bin/env runhaskell

primes :: [Int]
primes = 2 : filter prime [3, 5..]
         where
           factor x y = x `rem` y == 0
           prime x =
                   let candidates = takeWhile (\y-> y*y <= x) primes
                   in not $ any (factor x) candidates

                      
max_pow :: (Num a, Ord a) => a -> a -> a
max_pow top x = maxima (<=top) $ iterate (*x) x
    where
      maxima f l = last $ takeWhile f l

               
foobar :: Int -> Int
foobar n = product $ map (max_pow n) $ takeWhile (<=n) primes
           

main :: IO ()
main = print $ foobar 20 
