#!/usr/bin/env runhaskell

import Control.Applicative

-- Use matrix size and length of vector to create all adjacent pairs
chunks :: [a] -> Int -> [[(Int, Int)]]
chunks m len = filter inbounds $ apply (zipWith vec x_dim y_dim) matrix
    where
      inbounds = all (\(x,y)-> x>=0 && y>=0)
      dim      = length m - len
      matrix   = [(x,y) | x <- [0..dim], y <- [0..dim]]
      x_dim    = [(+),(+),(+),(u)]   
      y_dim    = [(-),(+),(u),(-)]   
      u x _    = x
      vec l r (x,y) =  [(l x i, r y i) | i <- [0 .. len-1]]

-- Apply list of functions to list of values
apply :: [a -> b] -> [a] -> [b]
apply fs as = fs <*> as

-- Get contents of coordinate in matrix              
index :: [[a]] -> (Int, Int) -> a
index m (x,y) = m !! y !! x

--map all indeces to matrix terms
map_to :: [[b]] -> [[(Int, Int)]] -> [[b]]
map_to a b = (map.map) (index a) b
              

main :: IO ()
main = do
  text    <- readFile "numbers_11.txt"
  grids   <- return $ map words $ lines text
  gridi   <- return $ (map.map) (\x -> read x :: Int) grids
  print . maximum $ map product $ map_to gridi (chunks gridi 4)
