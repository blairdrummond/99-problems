main = return $ maximum $ filter (\x -> show x == (reverse $ show x))
    [ x*y | x<-[100..999], y <-[100..999]]
