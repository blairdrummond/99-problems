primes = [2,3,5,7] ++ primes' [2,3,5,7] 10 

-- A few things could be improved, but at least it's infinite and tail recursive
primes' :: [Int] -> Int -> [Int]
primes' p n = let new = (filter 
                         (\x -> all (\y -> x `mod` y /= 0) (takeWhile  (\y -> y <= (ceiling $ sqrt $ fromIntegral x)) p))
                         (map (+n) [1,3,7,9]))
              in
                new ++ primes' (p ++ new) (n+10) 
                        
main = return $ primes !! 10000
