(define (primes k) (primelist `(2 3) k 5))

(define (primelist l k n) (cond ((< k n) l)
			        ((every (lambda (x) (not (eq? 0 (remainder n x)))) l)     (primelist   (cons n l)  k  (+ n 2)))
				(else    (primelist  l  k  (+ n 2)))))

(define (largest n) (fold-left * 1 (primes n))) 
