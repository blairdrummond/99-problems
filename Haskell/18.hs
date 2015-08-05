import Data.List
import Data.Ord

data Chain = Chain { chain :: [Int] }
           deriving Show

instance Ord Chain where
    Chain a `compare` Chain b = (sum a) `compare`  (sum b)
                                
instance Eq Chain where
    Chain a == Chain b = (sum a) == (sum b)

path triangle = head $ foldr row l (init triangle)
    where
      l = [ Chain [x] | x <- last triangle]
    

row :: [Int] -> [Chain] -> [Chain]
row heads branches = zipWith (\x y-> Chain (x: (chain y))) -- Add next row to beginning
                     heads $
                           zipWith -- Best of left and right chain
                           max
                           (init branches) --left
                           (tail branches) --right
                           
main = do
  triangle <- readFile "numbers_17.txt"
  clean    <- return $ (map.map) (\x -> read x :: Int) $ map words $ lines triangle
  return $ sum $ chain $ path clean
