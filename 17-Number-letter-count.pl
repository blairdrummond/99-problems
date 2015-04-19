ones(0)     --> [].
ones(1)     --> [one].
ones(2)     --> [two].
ones(3)     --> [three].
ones(4)     --> [four].
ones(5)     --> [five].
ones(6)     --> [six].
ones(7)     --> [seven].
ones(8)     --> [eight].
ones(9)     --> [nine].

tens(0,0)   --> [zero]                ,!.
tens(0,X)   --> ones(X)               ,!.
tens(1,0)   --> [ten]                 ,!.
tens(1,1)   --> [eleven]              ,!.
tens(1,2)   --> [twelve]              ,!.
tens(1,X)   --> pre(X), [teen]        ,!.
tens(X,Y)   --> pre(X), [ty], ones(Y) ,!.


hund([0,Y,Z]) --> tens(Y,Z), !.
hund([X,Y,Z]) --> ones(X), [hundred], tens(Y,Z). 


zhund(X,Y) :- hund(X,Y,[]), !.

pre(2) --> [twen]  ,!.
pre(3) --> [thir]  ,!.
pre(4) --> [for]   ,!.
pre(5) --> [fif]   ,!.
pre(X) --> ones(X) ,!.

num(X,Y)      :- numtolistprime(X,L), chunk(L,Y).

wordnum(X,[negative|Y]) :- X < 0, X1 is -X, parsenum(X1,Y),!.
wordnum(X,      Y     ) :- parsenum(X,Y).
 

parsenum(X,Y) :- num(X,X1), 
		 maplist( zhund, X1, X2 ), 
		 metric(L), 
		 coallate( L, X2, Y1 ), 
		 reverse(Y1,Y2),
		 flatten1(Y2,Y),
		 !.

coallate(  _,     [],         []  ).
coallate( [], [X|XS],     [X|XS]  ).
coallate( [X|XS], [Y|YS], [X,Y|T] ) :- coallate( XS, YS, T).

metric([[], [thousand], [million],[billion], [trillion]]). 

chunk( []        , []          ) :- !.
chunk( [X|[]]    , [[0,0,X]]   ) :- !.
chunk( [X,Y|[]]  , [[0,Y,X]]   ) :- !.
chunk( [X,Y,Z|T] , [[Z,Y,X]|B] ) :- chunk(T,B).


numtolistprime(0,[0])   :- !.
numtolistprime(X, [X])  :- X < 10, !.
numtolistprime(X,[H|T]) :- H is mod(X,10), P is X//10, numtolistprime(P,T).

flatten1([],[]).
flatten1([[]|T], T1)        :- flatten1(T,T1).
flatten1([[X|Y]|T], [X|T1]) :- flatten1([Y|T],T1).

myconcat(X,Y,Z) :- string_concat(Y,X,Z).
