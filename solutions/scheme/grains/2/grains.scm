(import (rnrs))
(use-modules (srfi srfi-1))

(define (square n)
  (if (or (< n 1) (> n 64))
      (raise "Invalid argument")
      (expt 2 (1- n))))

(define total
  (apply + (map square (iota 64 1))))

