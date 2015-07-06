import Data.List

fib n = takeWhile (<n) $ snd $ unzip $ iterate (\(a,b) -> (b,a+b)) (0,1)

main = return $ foldl1' (+) $ filter (\x -> x `mod` 2 == 1) $ fib 4000000
