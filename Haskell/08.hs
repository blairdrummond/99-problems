import System.IO
import Control.Monad
import Data.List
import Data.Char

prodmax :: [Integer] -> Int -> Integer
prodmax n len = maximum $ map product $ lengths len n 

lengths len l = [take len $ drop y l | y <- [0.. length l - len]]
 
main = do
  n <- readFile "numbers_08.txt"
  return $ prodmax (map (toInteger . digitToInt) $ filter (/='\n') n) 13
