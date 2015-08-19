#!/usr/bin/env runhaskell

import Data.Ord
import Data.List

-- Thanks to a bro on #haskell for this...
newtype FakeInt = FakeInt Integer
    deriving (Eq, Ord, Show) -- no Show/Read, as it would let you construct invalid FakeInts by default

fakeInt' :: Integer -> FakeInt
fakeInt' x | x > fromIntegral (maxBound :: Int) = error ("too big: " ++ show x)
fakeInt' x | x < fromIntegral (minBound :: Int) = error ("too small: " ++ show x)
fakeInt' x = FakeInt x


instance Num FakeInt where
    (FakeInt x) + (FakeInt y) = fakeInt' (x + y)
    (FakeInt x) * (FakeInt y) = fakeInt' (x * y)
    abs (FakeInt x)    = fakeInt' (abs x)
    signum (FakeInt x) = fakeInt' (signum x)
    fromInteger x      = fakeInt' (fromInteger x)
    negate (FakeInt x) = fakeInt' (negate x)

instance Real FakeInt where
    toRational (FakeInt x) = toRational x

instance Enum FakeInt where
    fromEnum (FakeInt x) = fromEnum x
    toEnum x = fakeInt' (toEnum x)

instance Bounded FakeInt where
    minBound = fromIntegral (minBound :: Int)
    maxBound = fromIntegral (maxBound :: Int)

instance Integral FakeInt where
    quotRem (FakeInt x) (FakeInt y) =
        let (x', y') = quotRem x y in
        (fakeInt' x', fakeInt' y')
    toInteger (FakeInt x) = x

                          
chain :: Integral a => a -> (a, Int)
chain n = (n, (length $ takeWhile (>1) $ iterate collatz' n))

collatz' :: Integral a => a -> a
collatz' n
    | r == 0 = q
    | otherwise = 3*n+1
    where
      (q,r) = quotRem n 2

              
main :: IO () 
main = print $ test2 (1000000 :: FakeInt)

test2 :: Integral a => a -> a
test2 n =
    let l = map chain [1..n]
        m = maximumBy (comparing snd) l
      in fst $ minimumBy (comparing fst) $ filter (\x -> (snd x) == (snd m)) l
