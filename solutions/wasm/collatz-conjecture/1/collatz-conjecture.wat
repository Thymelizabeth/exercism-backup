(module
  ;;
  ;; Return the number of steps needed to reach 1 in the Collatz conjecture.
  ;;
  ;; @param {i32} number - The number to start from.
  ;;
  ;; @returns {i32} - The number of steps needed to reach 1.
  ;;
  (func $steps (export "steps") (param $number i32) (result i32)
	(local $result i32)
	(local.set $result
		   (i32.const 0))
	(if (i32.lt_s
	     (local.get $number)
	     (i32.const 1)
	     )
	    (then
	     (return
	       (i32.const -1)
	       )
	     )
	    )
	(loop $step
	      (if (i32.eq
		   (i32.const 1)
		   (local.get $number)
		   )
		  (then
		   (return
		     (local.get $result)
		     )
		   )
		  )
	      (local.set $number
			 (select
			  (i32.add
			   (i32.const 1)
			   (i32.mul
			    (i32.const 3)
			    (local.get $number)
			    )
			   )
			  (i32.div_u
			   (local.get $number)
			   (i32.const 2)
			   )
			  (i32.rem_u
			   (local.get $number)
			   (i32.const 2)
			   )
			  )
			 )
	      (local.set $result
			 (i32.add
			  (i32.const 1)
			  (local.get $result)
			  )
			 )
	      br $step
	      )
	(unreachable)
	)
  )
