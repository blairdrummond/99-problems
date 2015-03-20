import Data.List


-- Strictness is handy in a really large sum
sumPrimes :: Integer -> Integer
sumPrimes n = foldl' (+) 0 (primeList n)

primeList :: Integer -> [Integer]
primeList n   = clean $ primeList' n
                where
                  clean []     = []
                  clean (x:xs) = x: (clean $ filter ((\x' y -> y `mod` x' /= 0) x)  xs)

                                 
primeList' n  = reverse $ primeBuilder [19, 17, 13, 11, 7, 5, 3, 2] n
    where
      primeBuilder l@(a:b:c:d:xs) n = 
          if   n <= a
          then dropWhile (n<) l
          else primeBuilder ((a+10):(b+10):(c+10):(d+10):l) n
