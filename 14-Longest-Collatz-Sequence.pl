:-dynamic(found/2).

collatz(1,0) :- !.
collatz(X,Y) :- found(X,Y), !.
collatz(X,Y) :- 1 is mod(X,2), X1 is 3*X+1, collatz(X1,Y1), Y is Y1+1, assert(found(X,Y)), !.
collatz(X,Y) :- 0 is mod(X,2), X1 is X/2,   collatz(X1,Y1), Y is Y1+1, assert(found(X,Y)), !.

longest(N,S) :- gensols(N), findall((X,Y),  (found(X,Y), N >= X), List), maxlist(List,S),!.

gensols(0).
gensols(N) :- collatz(N,_), N1 is N-1, gensols(N1).

maxlist([(A,B)|[]],(A,B)).
maxlist([(A,B)|T] ,(C,D)) :- maxlist(T,(I,J)), (J > B) -> (C = I, D = J); (C = A, D = B).
