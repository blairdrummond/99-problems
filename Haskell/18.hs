#!/usr/bin/env runhaskell

data Chain = Chain { best_path :: [Int] }
           deriving Show

instance Ord Chain where
    Chain a `compare` Chain b = (sum a) `compare` (sum b)

instance Eq Chain where
    Chain a == Chain b = (sum a) == (sum b)

path :: [[Int]] -> Chain
path triangle = head $ foldr row l (init triangle)
    where
      l = [ Chain [x] | x <- last triangle]

row :: [Int] -> [Chain] -> [Chain]
row heads branches = zipWith (\x y-> Chain (x : (best_path y))) -- Add next row to beginning
                     heads $
                           zipWith -- Best of left and right best_path
                           max
                           (init branches) --left
                           (tail branches) --right

main :: IO ()
main = do
  triangle <- readFile "numbers_18.txt"
  clean    <- return $ (map.map) (\x -> read x :: Int) $ map words $ lines triangle
  print . sum . best_path $ path clean
