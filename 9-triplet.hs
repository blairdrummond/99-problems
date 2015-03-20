{-
  Explanation:
  This is a bit messy, because it had to be optimized in hacky ways.

  The list comprehension takes an a, which narrows the range of b to between a+1 and (n-a)/2 (since c needs to be larger than b). c is never explicitly chosen, because it is implicit in the equation a+b+c= n. At the end of a choice, a^2+b^2=c^2 is tested. If a result is found, laziness will stop here, the head will be returned, and the product of the triplet will be taken.
-}

triplet :: Integer -> Integer
triplet n = product $ head [ [ a,b,(n -(a+b)) ] | a <- [1.. (n `quot` 3)], b <- [(a+1)..((n-a) `quot` 2) ], a^2+b^2 == (n-(a+b))^2 ]
