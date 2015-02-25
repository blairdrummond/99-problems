% not attrocious, but no where near capable of the following problem.
% "What is the largest prime factor of the number 600851475143 ?" 
% This system saves all found prime numbers, which is helpful, but it could be smarter in its method for generating the next prime numbers. At the moment, it increments by 2 and tests.
% This is a serious shortcoming.
% In addition, I should find out how to find maximums in a better way than first generating a list, then finding the max.


:- dynamic(found/1).
:- dynamic(count/1).

% will store prime(X), and highest(X)
% Load primes smallest to largest.

prime(2) :- !.
prime(3) :- !.
prime(P) :- found(prime(P)),!.

prime(X) :- findall(P, found(prime(P)), L),
	    max_member(M, L),
	    M > X, !, fail.

prime(X) :- find(X).

find(X) :- genP(X), !,
	   findall( P, found(prime(P)), L ),
	   maplist(notfactorof(X), L ),
	   assert(found(prime(X))),
	   write(X),nl.

genP(X) :- init,
	   findall(P, found(prime(P)), L),
	   max_member(M, L),
	   gen(X,M).

eval(X,Y) :- !, sqrt(X) =< Y.
gen(X,M) :-  eval(X,M),!.
gen(X,M) :- fcount(C),
	    K is round(sqrt(C)),
	    findall(
		        P, 
		        (found(prime(P)) , between(2, K ,  P)),
		        L
		   ),
	    maplist(notfactorof(C), L ) -> (assert(found(prime(C))), write(C),nl, gen(X,C));
	                                   gen(X,M).
	
init :- retractall(found(prime(2))), retractall(found(prime(3))), fail.
init :- asserta(found(prime(2))),  asserta(found(prime(3))).

fcount(X) :- count(X), retract(count(X)), X2 is X + 2, assert(count(X2)),!.
fcount(5) :- assert(count(5)).

% X doesn't have factor Y
notfactorof(X,Y) :-  not( 0 is mod(X,Y)).
factorof(X,Y) :- 0 is mod(X,Y).

flushx :- retractall(found(_)), retractall(count(_)).


largestPrimeFactor(X,F) :- prime(X) -> F = X;
			   (
			       K is round(sqrt(X)),
			       findall(P, 
				          ( 
					      found(prime(P)), 
					      between(2, K , P), 
					      factorof(X,P) 
			                  ),L),
			       max_member(F,L)
			   ).
