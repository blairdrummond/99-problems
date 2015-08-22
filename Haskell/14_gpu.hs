#!/usr/bin/env runhaskell

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}


import Data.Array.Accelerate as A
import Prelude as P
import Data.Ord
import Data.List

import Data.Array.Accelerate.Interpreter (run)
--import Data.Array.Accelerate.CUDA        (run)

main :: IO ()
main = print $ P.fst $ maximumBy (comparing P.snd) (collatz 1000000)
       
collatz :: Int64 -> [(Int64, Int)]
collatz n = toList $ run $ A.map collatz' (use (fromList (Z:. P.fromIntegral n) [1..n] :: Vector Int64))

collatz' :: (Lift Exp t, Plain t ~ Int64) => t -> Exp (Int64, Int)
collatz' n = lift (n, A.snd (collatz'' (lift (n,0 :: Int))))
            
collatz'' :: Exp (Int64, Int) -> Exp (Int64, Int)
collatz'' a = while (\t -> A.fst t /=* 1) next a

next :: Exp (Int64, Int) -> Exp (Int64, Int)
next x = let a = A.fst x
             b = A.snd x
         in (A.even a) ? 
               (
                (lift (a `quot` 2, b+1) :: Exp (Int64, Int)),
                (lift (a*3+1, b+1) :: Exp (Int64, Int))
               )
 
