
f :: Integer -> Integer
f n = n*(n+1) `quot` 2

soln x = head [ v | v <- (map f [1..]), length [ q | q <- [1.. v], v `mod` q == 0] >= x  ]
