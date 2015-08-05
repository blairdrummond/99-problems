-- Not effecient enough

import Data.List

tris :: [Integer]
tris = snd $ mapAccumL (\x y -> (x+y,x+y)) 0 [1..]

primes :: [Integer]
primes = 2:filter isPrime [3,5..]
    where
      isPrime p = all (\r-> p `mod` r > 0) $ takeWhile (\q->q*q <= p) primes

p_factors :: Integer -> [Integer]
p_factors n = filter (\r-> n `mod` r == 0) $ takeWhile (\p->p*p <= n) primes

factors :: Num a => Integer -> a
factors n = 1 + (product $ map (maximal n 1) (p_factors n))
    where
      maximal x acc m =
          let (q,r) = quotRem x m
          in
            if r == 0
            then maximal q (acc+1) m
            else acc

main :: IO Integer
main = return $ head $ filter (\x -> factors x > 500) tris
