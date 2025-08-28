(import (rnrs))

(define (two-fer . maybe-name)
  (string-append "One for " (or (find (const #t) maybe-name) "you") ", one for me."))

