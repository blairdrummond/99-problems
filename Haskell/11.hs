import Control.Applicative
import Control.Monad
import Data.Char
import Data.List
import System.IO

-- Use matrix size and length of vector to create all adjacent pairs
chunks :: [a] -> Int -> [[(Int, Int)]]
chunks m len = filter (all (\(x,y)-> x>=0 && y>=0)) $ apply (zipWith vec x_dim y_dim) [(x,y) | x <- [0..dim], y <- [0..dim]]
    where
      dim = length m - len
      vec l r (x,y) =  [(l x i, r y i) | i <- [0 .. len-1]]
      x_dim = [(+),(+),(+),(u)]   
      y_dim = [(-),(+),(u),(-)]   
      u x _ = x

-- Apply list of functions to list of values
apply :: [a -> b] -> [a] -> [b]
apply fs as = fs <*> as

-- Get contents of coordinate in matrix              
index :: [[a]] -> (Int, Int) -> a
index m (x,y) = m !! y !! x

--map all indeces to matrix terms
map_to :: [[b]] -> [[(Int, Int)]] -> [[b]]
map_to a b = (map.map) (index a) b
              

main :: IO Integer
main = do
  text    <- readFile "numbers_11.txt"
  grids   <- return $ map words $ lines text
  gridi   <- return $ (map.map) (\x -> read x :: Integer) grids
  return $ maximum $ map product $ map_to gridi (chunks gridi 4)
