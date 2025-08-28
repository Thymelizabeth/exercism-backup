(import (rnrs))

(define (square-of-sum n)
  (expt (apply + (iota n 1)) 2))

(define (sum-of-squares n)
  (apply + (map (lambda (x) (* x x)) (iota n 1))))

(define (difference-of-squares n)
  (- (square-of-sum n) (sum-of-squares n)))



