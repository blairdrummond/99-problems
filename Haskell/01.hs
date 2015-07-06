three_or_five :: Int -> Int
                         -- 3s    +     5s               -union 3x5
three_or_five x = sum $ [3,6..x] ++ [5,10..x] ++ [-15, -30 .. -x]

main = return $ three_or_five 999
