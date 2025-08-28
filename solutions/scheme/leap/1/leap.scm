(import (rnrs))

(define (leap-year? year)
  (or (= 0 (modulo year 400))
      (and (not (= 0 (modulo year 100)))
           (= 0 (modulo year 4)))))

