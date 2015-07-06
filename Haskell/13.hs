import System.IO
import Control.Monad
import Data.List
import Data.Char
    
split :: Char -> String -> [String]
split at s = reverse $ map reverse $ split' at s "" []

split' at ""       build acc = if build == ""
                               then acc
                               else build:acc
                                    
split' at (x:xs)   build acc = if x == at
                               then split' at xs    []     (build:acc)     
                               else split' at xs (x:build)    acc

digit :: Integer -> [Integer] -> (Integer, [Integer])
digit acc x = ( acc*10, map (*acc) x ) 

do_undo u f x = u $ f $ u x 

firstX :: Int -> [[Integer]] -> Integer
firstX x m = mod (foldl' (+) 0 $ concatMap id $ snd $ mapAccumL digit 1 $ transpose $ map (take x) $ map reverse m) (10^x)


main =  do
  text   <- (readFile "numbers_13.txt")
  matrix <- return $ (map.map) (toInteger . digitToInt) $ split '\n' text
  return $ firstX 10 matrix
