(import (rnrs))

(define (dna->rna dna)
  (string-map (lambda (nucleotide) 
         (cond ((char=? #\A nucleotide) #\U)
               ((char=? #\C nucleotide) #\G)
               ((char=? #\G nucleotide) #\C)
               ((char=? #\T nucleotide) #\A)))
       dna))

