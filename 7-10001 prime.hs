
prime :: Integer -> Bool
prime n = (last $ primeList n) == n
                                   
primeList n   = clean $ reverse $ primeList' n
                where
                  clean []     = []
                  clean (x:xs) = x: (clean $ filter ((\x' y -> y `mod` x' /= 0) x)  xs)

                                 
primeList' n  = primeBuilder [19, 17, 13, 11, 7, 5, 3, 2] n
    where
      primeBuilder l@(a:b:c:d:xs) n = 
          if   n <= a
          then dropWhile (n<) l
          else primeBuilder ((a+10):(b+10):(c+10):(d+10):l) n

-- The list is reversed
findprime n = last $ primeList n
