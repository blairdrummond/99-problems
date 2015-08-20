# 99-problems
Project Euler problems in many languages

Problems from:  https://projecteuler.net/archives

Only the Haskell problems are verified (They're the only ones that I really pay attention to).

14 is by far the slowest of all the problems so far (~8s). I'm trying different ways to optimize it. So far, parallelization didn't help (it was actually almost a second slower). Using a Map made a marginal difference, but nothing substantial. I want to see the the Map technique can be further optimized, or maybe parallelized.

18.hs is my favorite piece so far (It should be good enough to handle the upcoming problem 67)



Thing I learnt recently: The types make a huge difference. Integer is So much slower than Int.
(but be cautious of overflow)
