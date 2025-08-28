(module
  (memory (export "mem") 1)

  ;;
  ;; Count the number of each nucleotide in a DNA string.
  ;;
  ;; @param {i32} offset - The offset of the DNA string in memory.
  ;; @param {i32} length - The length of the DNA string.
  ;;
  ;; @returns {(i32,i32,i32,i32)} - The number of adenine, cytosine, guanine, 
  ;;                                and thymine nucleotides in the DNA string
  ;;                                or (-1, -1, -1, -1) if the DNA string is
  ;;                                invalid.
  ;;
  (func (export "countNucleotides") (param $offset i32) (param $length i32) (result i32 i32 i32 i32)
	(local $i i32)
    (call $recursive-count
	  (local.get $offset)
	  (i32.add (local.get $offset) (local.get $length))
	  (i32.const 0)
	  (i32.const 0)
	  (i32.const 0)
	  (i32.const 0)))

  (func $recursive-count (param $i i32) (param $end i32)
	(param $a i32) (param $c i32) (param $g i32) (param $t i32)
	(result i32 i32 i32 i32)
   (if (result i32 i32 i32 i32) (i32.lt_u (local.get $i) (local.get $end))
       (then
	(if (i32.eq (i32.load8_u (local.get $i)) (i32.const 65))
	    (then (return (call $recursive-count
				(i32.add (local.get $i) (i32.const 1))
				(local.get $end)
				(i32.add (local.get $a) (i32.const 1))
				(local.get $c)
				(local.get $g)
				(local.get $t)))))
	(if (i32.eq (i32.load8_u (local.get $i)) (i32.const 67))
	    (then (return (call $recursive-count
				(i32.add (local.get $i) (i32.const 1))
				(local.get $end)
				(local.get $a)
				(i32.add (local.get $c) (i32.const 1))
				(local.get $g)
				(local.get $t)))))
	(if (i32.eq (i32.load8_u (local.get $i)) (i32.const 71))
	    (then (return (call $recursive-count
				(i32.add (local.get $i) (i32.const 1))
				(local.get $end)
				(local.get $a)
				(local.get $c)
				(i32.add (local.get $g) (i32.const 1))
				(local.get $t)))))
	(if (i32.eq (i32.load8_u (local.get $i)) (i32.const 84))
	    (then (return (call $recursive-count
				(i32.add (local.get $i) (i32.const 1))
				(local.get $end)
				(local.get $a)
				(local.get $c)
				(local.get $g)
				(i32.add (local.get $t) (i32.const 1))))))
	(return
	  (i32.const -1)
	  (i32.const -1)
	  (i32.const -1)
	  (i32.const -1)))
       (else
	(return
	  (local.get $a)
	  (local.get $c)
	  (local.get $g)
	  (local.get $t)))))
)
