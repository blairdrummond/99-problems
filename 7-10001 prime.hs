
{-
This is horribly inefficient, it generates n lists of all prime numbers.
This was built out of old code. It should really be redesigned to make a single list of prime numbers.
-}


prime :: Integer -> Bool
prime 2 = True
prime n = testFactor n (2:[3,5.. (floor $ sqrt $ fromIntegral n)])
    where
        testFactor :: Integer -> [Integer] -> Bool
        testFactor m []     = True
        testFactor m (x:xs) = if (mod m x == 0)
                              then False
                              else testFactor m xs


findprime n = head $ drop (n-1) [ x | x <- [1..], prime x]
