import Data.Ord
import Data.List

longest n = maximumBy (comparing fst) [ (length $ takeWhile (/=1) (iterate collatz s), s) | s <-[1..n]]

collatz n = if    n `mod` 2 == 0
            then  n `quot` 2
            else  3*n+1
