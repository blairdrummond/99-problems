import Data.List

-- SLOW!!!
    
primes :: [Integer]
primes = 2:3:5:7:filter isPrime [(x+i) | i<-[10,20..], x<-[1,3,7,9]]
    where
      isPrime p = all (\q -> p `mod` q > 0) $ takeWhile (\q -> q*q <= p) primes
                      
main :: IO Integer
main = return $ foldl1' (+) $ takeWhile (<2000000) primes
