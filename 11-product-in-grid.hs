import Data.List

--NOT DONE


maxProduct :: [[Integer]] -> Int -> Integer
maxProduct matrix size = maximum $ map product $ concatMap (\x -> chunk x size) (matrix ++ transpose matrix)

chunk :: [a] -> Int -> [[a]]
chunk l n = [ take n ( drop x l) | x <- [0.. (length l - n)]]

diagonal m size op = 

diagonal' _  _  []    = []
diagonal' op c (x:xs) = op c x : diagonal' op (c+1) xs 

