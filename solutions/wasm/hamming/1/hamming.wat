(module
  (memory (export "mem") 1)

  ;;
  ;; Calculate the hamming distance between two strings.
  ;;
  ;; @param {i32} firstOffset - The offset of the first string in linear memory.
  ;; @param {i32} firstLength - The length of the first string in linear memory.
  ;; @param {i32} secondOffset - The offset of the second string in linear memory.
  ;; @param {i32} secondLength - The length of the second string in linear memory.
  ;;
  ;; @returns {i32} - The hamming distance between the two strings or -1 if the
  ;;                  strings are not of equal length.
  ;;
  (func (export "compute") 
    (param $firstOffset i32) (param $firstLength i32) (param $secondOffset i32) (param $secondLength i32) (result i32)
    (if (result i32) (i32.ne (local.get $firstLength) (local.get $secondLength))
	(then (i32.const -1))
	(else (call $hamming
			    (local.get $firstOffset)
			    (local.get $secondOffset)
			    (local.get $firstLength)
			    (i32.const 0)))))

  (func $hamming (param $firstOffset i32) (param $secondOffset i32) (param $length i32) (param $index i32) (result i32)
	(if (result i32) (i32.lt_u (local.get $index) (local.get $length))
	    (then (i32.add
		   (i32.ne
		    (i32.load8_u
		     (i32.add
		      (local.get $firstOffset)
		      (local.get $index)))
		    (i32.load8_u
		     (i32.add
		      (local.get $secondOffset)
		      (local.get $index))))
		   (call $hamming
			 (local.get $firstOffset)
			 (local.get $secondOffset)
			 (local.get $length)
			 (i32.add (local.get $index) (i32.const 1)))))
	    (else (i32.const 0)))))
