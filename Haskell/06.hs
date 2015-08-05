import Data.List 

difference :: Integer  -> Integer
difference n =  (foldl' (+) 0 [1..n])^2 - (foldl' (\ x y -> x + y^2) 0 [1..n])


main = return $ difference 100
