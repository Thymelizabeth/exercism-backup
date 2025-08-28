(module
  (memory (export "mem") 1)
  (data (i32.const 0) "One for you, one for me.")
  ;;
  ;; Given a string X, return a string that says "One for X, one for me."
  ;; If the X is empty, return the string "One for you, one for me."
  ;;
  ;; @param {i32} $offset - The offset of the name in linear memory.
  ;; @param {i32} $length - The length of the name in linear memory.
  ;; 
  ;; @return {(i32,i32)} - The offset and length the resulting string in linear memory.
  ;;
  (func (export "twoFer") (param $offset i32) (param $length i32) (result i32 i32)
	(if (result i32 i32) (i32.eq (local.get $length) (i32.const 0))
	    (then
	     (return (i32.const 0) (i32.const 24)))
	    (else
	     (memory.copy (i32.add (local.get $offset) (local.get $length)) (i32.const 11) (i32.const 13))
	     (memory.copy (i32.sub (local.get $offset) (i32.const 8)) (i32.const 0) (i32.const 8))
	     (return
	       (i32.sub
		(local.get $offset)
		(i32.const 8))
	       (i32.add
		(local.get $length)
		(i32.const 21)))))))
