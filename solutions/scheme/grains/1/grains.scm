(import (rnrs))
(use-modules (srfi srfi-1))

(define (square n)
  (if (or (< n 1) (> n 64))
      (raise "Invalid argument")
      (expt 2 (1- n))))

(define total
  (fold (lambda (acc n) (+ acc (square n))) 0 (unfold (lambda (n) (= n 64)) identity 1+ 1)))

