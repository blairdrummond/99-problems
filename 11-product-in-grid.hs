import Data.List

{-
   the matrix and transpose matrix provide horizaontals and verticals. The diagonals are trickier.

   diagonal' drop 4 M

   x x x x x x         - - - - x x
   x x x x x x         - - - x x x 
   x x x x x x    ->   - - x x x x 
   x x x x x x         - x x x x x
   x x x x x x         x x x x x x
   x x x x x x         x x x x x x

   the '-' means null.

   basically, cut a triangular slice out of the list, (top and bottom)
   then the rows above one another are actually diagonals. Take the tarnspose to turn these columns into rows
   then supply the rows to the usual chunker. You must seperately account for the slice that you remove, but the process is similar.

-}

maxProduct :: [[Integer]] -> Int -> Integer
maxProduct matrix size = maximum $ map product $ concatMap (\x -> chunk x size) (matrix ++ transpose matrix ++ diagonals matrix )

chunk :: [a] -> Int -> [[a]]
chunk l n = [ take n ( drop x l) | x <- [0.. (length l - n)]]


diagonals :: [[a]] -> [[a]]
diagonals m = diagonal m ++ diagonal (reverse m)

--                top of Left-Down                  bottom of Left-Down
diagonal m = transpose ( diagonal' drop 0 m ) ++ (transpose $ diagonal' (\x y-> reverse $ take x y) 0 m) 
  where
    diagonal' op _  []    = []
    diagonal' op c (x:xs) = (op c x) : diagonal' op (c+1) xs 

