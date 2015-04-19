
%============================ GRAMMAR ===================================
% DCG that creates a list of words and affixes that represent the number

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

zhund(X,Y) :- hund(X,Y1,[]), affixclean(Y1,Y), !.

pre(2) --> [twen]  ,!.
pre(3) --> [thir]  ,!.
pre(4) --> [for]   ,!.
pre(5) --> [fif]   ,!.
pre(X) --> ones(X) ,!.

affixclean( []     ,  []      ) :- !.
affixclean( [A|[]] ,  [A]     ) :- !.
affixclean( [A,B|T], [AB|TS]  ) :- (B == teen; B == ty) -> ( atom_string(A,A1), 
	 						     atom_string(B,B1), 
						             string_concat(A1,B1,AB1),
						             atom_string(AB,AB1),
							     affixclean(T,TS)
							   ),!.
affixclean( [A|T], [A|TS] ) :- affixclean(T,TS).

% =============================== END GRAMMAR =======================================


wordnum(X,Z) :- X < 0, X1 is -X, wordnum(X1,Y), string_concat('negative ',Y,Z), !.
wordnum(X,Z) :- parsenum(X,Y), toString(Y,Z).
 

parsenum(X,Y) :- num(X,X1), 
		 maplist( zhund, X1, X2 ), 
		 metric(L), 
		 collate( L, X2, Y1 ), 
		 reverse(Y1,Y2),
		 flatten1(Y2,Y),
		 !.

collate(  _,     [],         []  ).
collate( [], [X|XS],     [X|XS]  ).
collate( [X|XS], [Y|YS], [X,Y|T] ) :- collate( XS, YS, T).

metric([[], [thousand], [million],[billion], [trillion]]). 


num(X,Y)      :- numtolistprime(X,L), chunk(L,Y).


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


toString(L,L2) :- toStringx(L,L1), foldl(myconcat, L1, '', L2).

toStringx([H|[]], [H1])          :- atom_string(H,H1), !.
toStringx([H|T],  [H1,' '|T1])   :- atom_string(H,H1), toStringx(T,T1).


% THE ACTUAL QUESTION PART


q17(N,ANS) :- wordnum(N,X), string_codes(X,Y), exclude( ==(32), Y, Z), length(Z,ANS).
