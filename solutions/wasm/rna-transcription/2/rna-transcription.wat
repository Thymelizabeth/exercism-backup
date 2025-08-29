(module
  (memory (export "mem") 1)

  ;;
  ;; Convert a string of DNA to RNA
  ;;
  ;; @param {i32} offset - The offset of the DNA string in linear memory
  ;; @param {i32} length - The length of the DNA string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the RNA string in linear memory
  ;;
  (func $to-rna (export "toRna") (param $offset i32) (param $length i32) (result i32 i32) (local $char i32)
    (if (i32.ne (local.get $length) (i32.const 0))
	(then
	 (local.set
	  $char
	  (i32.load8_u (local.get $offset)))
	 (i32.store8
	  (local.get $offset)
	  (select
	   (i32.const 85) ;; U
	   (select
	    (i32.const 71) ;; G
	    (select
	     (i32.const 67) ;; C
	     (select
	      (i32.const 65) ;; A
	      (local.get $char) ;; original char
	      (i32.eq (local.get $char) (i32.const 84))) ;; U
	     (i32.eq (local.get $char) (i32.const 71))) ;; G
	    (i32.eq (local.get $char) (i32.const 67))) ;; C
	   (i32.eq (local.get $char) (i32.const 65)))) ;; A
	 (drop (drop (call $to-rna
			   (i32.add
			    (local.get $offset)
			    (i32.const 1))
			   (i32.sub
			    (local.get $length)
			    (i32.const 1)))))))
    (return
      (local.get $offset)
      (local.get $length))
  )
)
