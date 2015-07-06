import Data.List

g :: [Int] -> [Int] -> [Int]
g []     acc = acc
g (x:xs) acc = let ys = filter (\y -> y `mod` x /= 0) xs in
               g ys (x:acc) 

foo bar p = foo' bar p p

foo' bar p i = let p' = p*i in
               if p' > bar
               then p
               else foo' bar p' i

foobar n = foldl' (*) 1 (map (foo n) $ g [2,3..n] [])

main = return $ foobar 20 
