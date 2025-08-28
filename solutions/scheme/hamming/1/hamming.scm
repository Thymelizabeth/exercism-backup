(import (rnrs))

(define (hamming-distance strand-a strand-b)
  (if (= (string-length strand-a) (string-length strand-b))
      (length (filter not (map char=? (string->list strand-a) (string->list strand-b))))
      (error "different lengths")))

