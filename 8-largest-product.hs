import Data.List

largestProduct n len = maximum $ map product $ chunk (numToList n) len

numToList n
    | n < 0     = numToList (-n)
    | n < 10    = [n]
    | otherwise = (n `mod` 10) : numToList (n `quot` 10)

chunk l n = [ take n $ drop x l | x <- [0.. (length l - n)]]

