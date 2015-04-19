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

hund([X,Y,Z]) --> ones(X), [hundred], tens(Y,Z). 

pre(2) --> [twen]  ,!.
pre(3) --> [thir]  ,!.
pre(4) --> [for]   ,!.
pre(5) --> [fif]   ,!.
pre(X) --> ones(X) ,!.



num(X,Y)      :- numtolistprime(X,L), chunk(L,Y).

parsenum(X,Y) :- num(X,X1), map( hund, X1, X2), 


chunk( []        , []          ) :- !.
chunk( [X|[]]    , [[0,0,X]]   ) :- !.
chunk( [X,Y|[]]  , [[0,X,Y]]   ) :- !.
chunk( [X,Y,Z|T] , [[Z,Y,X]|B] ) :- chunk(T,B).


numtolistprime(0,[]), !.
numtolistprime(X,[H|T]) :- H is mod(X,10), P is X/10, numtolist(P,T).




