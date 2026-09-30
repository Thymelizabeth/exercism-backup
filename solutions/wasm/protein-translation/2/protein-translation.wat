(module
  (memory (export "mem") 1)
  (data $methionine "Methionine\n") ;; 11 bytes
  (data $phenylalanine "Phenylalanine\n") ;; 14 bytes
  (data $leucine "Leucine\n") ;; 8 bytes
  (data $serine "Serine\n") ;; 7 bytes
  (data $tyrosine "Tyrosine\n") ;; 9 bytes
  (data $cysteine "Cysteine\n") ;; 9 bytes
  (data $tryptophan "Tryptophan\n") ;; 11 bytes

  ;;
  ;; Output the space-separated list of proteins specified by the space-separated list of codons
  ;;
  ;; @param {i32} $inputOffset - offset of the codon list in linear memory
  ;; @param {i32} $inputLength - length of the codon list in linear memory
  ;;
  ;; @returns {(i32,i32)} - offset and length of the protein list in linear memory
  ;;
  (func (export "translate") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $outputOffset i32)
    (local $outputPointer i32)
    (local $inputPointer i32)
    (local $codon i32)
    (local $acidLength i32)
    ;; Initialise variables
    (local.set $outputOffset
     (i32.add
      (local.get $inputOffset)
      (local.get $inputLength)))
    (local.set $outputPointer
     (local.get $outputOffset))
    (local.set $inputPointer
     (local.get $inputOffset))

    ;; Loop over codons until end of string
    (loop $codonLoop
     (local.set $acidLength
      (i32.const -1))
     (if
      (i32.lt_u
       (local.get $inputPointer)
       (local.get $outputOffset))
     (then
      ;; Get current codon
      (local.set $codon
       (i32.and
	(i32.const 0x00FFFFFF)
	(i32.load (local.get $inputPointer))))
      
      ;; Check current codon
      (if
       (i32.eq
	(local.get $codon)
	(i32.const 0x475541)) ;; AUG
      (then
       (local.set $acidLength
	(i32.const 11))
       (memory.init $methionine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x555555)) ;; UUU
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x435555))) ;; UUC
      (then
       (local.set $acidLength
	(i32.const 14))
       (memory.init $phenylalanine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x415555)) ;; UUA
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x475555))) ;; UUG
      (then
       (local.set $acidLength
	(i32.const 8))
       (memory.init $leucine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.or
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x554355)) ;; UCU
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x434355))) ;; UCC
	(i32.or
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x414355)) ;; UCA
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x474355)))) ;; UCG
      (then
       (local.set $acidLength
	(i32.const 7))
       (memory.init $serine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x554155)) ;; UAU
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x434155))) ;; UAC
      (then
       (local.set $acidLength
	(i32.const 9))
       (memory.init $tyrosine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x554755)) ;; UGU
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x434755))) ;; UGC
      (then
       (local.set $acidLength
	(i32.const 9))
       (memory.init $cysteine (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.eq
	(local.get $codon)
	(i32.const 0x474755)) ;; UGG
      (then
       (local.set $acidLength
	(i32.const 11))
       (memory.init $tryptophan (local.get $outputPointer) (i32.const 0) (local.get $acidLength)))
      (else (if
       (i32.or
	(i32.or
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x414155)) ;; UAA
	 (i32.eq
	  (local.get $codon)
	  (i32.const 0x474155))) ;; UAG
	(i32.eq
	 (local.get $codon)
	 (i32.const 0x414755))) ;; UGA
      (then
       (local.set $acidLength
	(i32.const 0))))))))))))))))))

      ;; Advance pointer
      (local.set $inputPointer
       (i32.add
	(local.get $inputPointer)
	(i32.const 3)))
      
      ;; check whether to continue looping
      (if
       (i32.gt_s
	(local.get $acidLength)
	(i32.const 0))
      (then
       (local.set $outputPointer
        (i32.add
 	 (local.get $outputPointer)
 	 (local.get $acidLength)))
       br $codonLoop)
      (else
       (if
	;; check whether error or STOP codon
	(i32.eq
	 (i32.const -1)
	 (local.get $acidLength))
	;; acidLength has not been set (invalid codon), error out
       (then
	(local.set $outputOffset
	 (i32.const -1)))))))))
    (data.drop $methionine)
    (data.drop $phenylalanine)
    (data.drop $leucine)
    (data.drop $serine)
    (data.drop $tyrosine)
    (data.drop $cysteine)
    (data.drop $tryptophan)
    (local.get $outputOffset)
    (i32.sub
     (local.get $outputPointer)
     (local.get $outputOffset))
  )
)
