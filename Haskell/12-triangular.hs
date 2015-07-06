-- Not effecient enough

import Data.List

bar = 500
    
main = return $ head $ filter (\x -> check x 2 (fg x)) tris
               
check x acc fs
      | acc >= bar      = True
      | x < 2^(bar-acc) = False
      | fs == []        = False
      | otherwise       = check x (acc+1) (tail fs)

fg x = 1 : (reverse $ f' 2 x [])


test x = length (fg x) == length (f 2 x [1] [x])

       
f' x n factors 
    |  n `mod` x == 0  = f' x (n `quot` x) (x:factors)
    |  n `quot` x < x  = n:factors
    | otherwise        = f' (x+1) n factors


{- All factors are in this list, remove those that are composite -}
g []     acc = acc
g (x:xs) acc = let ys = filter (\y -> y `mod` x /= 0) xs in
               g ys (x:acc) 

                          
f x n l@(fl:factorsl) r@(fr:factorsr)
    |  fl > fr        = reverse factorsl ++ factorsr
    |  fl == fr       = reverse factorsl ++ fl:factorsr
    |  n `mod` x == 0 = let d = n `quot` x in f x d (x:l) (d:r)  
    |  otherwise        = f (x+1) n l r

                         
tris :: [Integer]
tris = snd $ mapAccumL (\x y -> (x+y,x+y)) 0 [1..]
