import Data.List


-- Strictness is handy in a really large sum
sumPrimes :: Integer -> Integer
sumPrimes n = foldl1' (+) (primes n)

primes bound = primes'' (primes' bound) []

primes' bound = [2,3,5,7] ++ [ 1 `seq` (x+y) | x<-[10,20..((bound-9) `quot` 10)], y <-[1,3,7,9]]

primes'' (x:xs) acc = primes'' (filter (\y -> y `mod` x /= 0) xs) (x:acc)
primes''   []   acc = acc 


main = return $ sumPrimes 2000000
