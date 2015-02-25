% Sum of multiples of 3 and 5 below X
% Red cut heavy.
mysoln(0,0) :- !.
mysoln(X,Y) :- (0 is mod(X,5); 0 is mod(X,3)), % conditions
	     X1 is X - 1,
	     mysoln(X1, Y1),
	     Y is Y1 + X, !. % red cut
mysoln(X,Y) :- X1 is X - 1, mysoln(X1,Y).
