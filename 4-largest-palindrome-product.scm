;;; find largest palindrome below k

(define (find-palindrome k) (find-recurse k k))

(define (numToList n)  (if  (< n 10) (cons n ()) (cons (remainder n 10)  (numToList (truncate (/ n 10))))))

(define (palindrome a) (let ((l (numToList a))) 
			 (equal? l (reverse l))))

(define (find-recurse a b) (if (palindrome (* a b)) 
			      (* a b)  
			      (if (< a b)   
				  (find-recurse a       (- b 1) )  
				  (find-recurse (- a 1) b       ))))
