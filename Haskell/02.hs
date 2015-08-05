import Data.List

fibs = 1:1:zipWith (+) fibs (tail fibs) 

main = return $ foldl1' (+) $ filter even $ takeWhile (<=4000000) fibs
       where
         even x = x `mod` 2 == 0
