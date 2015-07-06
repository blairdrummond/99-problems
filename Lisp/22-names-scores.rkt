(require 2htdp/batch-io)

(define q
  (let* ((names     (sort (car (read-csv-file "names.txt")) string<?))  ;; Grab list from file
         (integers  (build-list (length names) values)))                ;; (0 1 2 3 ... )
    
    (foldl + 0  ;; sum the list
           (map   ;; map Lambda (x y) over names and (0 1 2 3 ...)
            (lambda (x y) (* y (foldl + 0 (map char->integer (string->list x))))) ;; word -> (index) * (sum of its letters)
            names
            integers))))    
  

