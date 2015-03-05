
(define (range a b) (if (eqv? a b) () (cons a (range (+ a 1) b)) ))
(define (products k) (let ((l (range 1 k))) 
		       (sort (append-map (lambda (x) (map (lambda (y) (* x y)) l)) l) >)))

(define (duplicates l) (let ((tail (cdr l)))
			 (cond 
			  ((null? l)               `()                      )
			  ((null? tail)             l                       ) 
			  ((eq? (car l) (cadr l))   (duplicates tail)       )
			  (else                     (cons (car l) (duplicates tail))))))

;;; This is actually in reverse, but that isn't important for our purposes
(define (numToList n)  (if  (< n 10) (cons n ()) (cons (remainder n 10)  (numToList (truncate (/ n 10))))))

(define (find-palin k) (find-recurse (duplicates (products k))))

(define (find-recurse l) (if (palindrome (car l))  l  (find-recurse (cdr l))))

(define (palindrome a) (let ((l (numToList a))) (
			 (eqv? l (reverse l)))))
