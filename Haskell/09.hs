#!/usr/bin/env runhaskell

   
triplets :: Integer -> [[Integer]]
triplets n = [[ a, b, (n - a - b) ] | a <- [   1    .. (   n   `quot` 3 ) ],
                                      b <- [ (a+1)  .. ( (n-a) `quot` 2 ) ],
                                      a^2+b^2 == (n-a-b)^2
             ]

triplet :: Integer -> Integer
triplet n = product . head $ triplets n


main :: IO ()
main = print $ triplet 1000
       
