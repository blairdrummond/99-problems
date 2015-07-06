(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))

(define (decomp n) (if (< n 10) (list n) (cons (modulo n 10) (decomp (quotient n 10)))))

(define (q18 n) (foldl + 0 (decomp (fact n))))
