(module
  (import "console" "log_mem_as_utf8" 
    (func $log_mem_as_utf8
      (param $byteOffset i32
      ) 
      (param $length i32
      )
    )
  )
  (memory (export "mem") 1)
 
  ;;
  ;; Reverse a string
  ;;
  ;; @param {i32} offset - The offset of the input string in linear memory
  ;; @param {i32} length - The length of the input string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the reversed string in linear memory
  ;;
  (func (export "reverseString") (param $offset i32) (param $length i32) (result i32 i32)
	(local $mid i32) (local $i i32)
    (local.set $mid (i32.add (local.get $offset) (i32.div_u (local.get $length) (i32.const 2))))
    (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
    (local.set $i (local.get $offset))

    (loop $i-loop
     (if (i32.lt_u (local.get $i) (local.get $mid))
	 (then
	  (call $log_mem_as_utf8
		(local.get $offset)
		(local.get $length))
	  (call $swap
		(local.get $i)
		(i32.sub
		 (i32.add
		  (local.get $offset)
		  (local.get $length))
		 (i32.sub
		  (i32.add
		   (local.get $i)
		   (i32.const 1))
		  (local.get $offset))))
	  (local.set $i
		     (i32.add
		      (local.get $i)
		      (i32.const 1)))
	  (br $i-loop))))
    (call $log_mem_as_utf8
	  (local.get $offset)
	  (local.get $length))
    (return (local.get $offset) (local.get $length)))

  (func $swap (param $a i32) (param $b i32) (local $c i32)
	(local.set
	 $c
	 (i32.load8_u (local.get $a)))
	(i32.store8
	 (local.get $a)
	 (i32.load8_u
	  (local.get $b)))
	(i32.store8
	 (local.get $b)
	 (local.get $c)))
)
