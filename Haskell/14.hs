import Data.Ord
import Data.List
import Data.Maybe
        
main :: IO Integer
main = return $ test2 1000000 

test2 :: Integral a => a -> a
test2 n = fst $ maximumBy (comparing snd) $ map chain [1..n]

chain :: Integral a => a -> (a, Int)
chain n = (n, (length $ takeWhile (>1) $ iterate collatz' n))

collatz' :: Integral a => a -> a
collatz' n
    | r == 0 = q
    | otherwise = 1 `seq` 3*n+1
    where
      (q,r) = quotRem n 2
