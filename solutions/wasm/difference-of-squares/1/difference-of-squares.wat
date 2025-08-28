(module
  ;;
  ;; Calculate the square of the sum of the first N natural numbers
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} The square of the sum of the first N natural numbers
  ;;
  (func $squareOfSum (export "squareOfSum") (param $n i32) (result i32)
    (local $sumOfN i32)
    (local.set $sumOfN
	       (i32.div_u
		(i32.mul
		 (i32.add
		  (i32.const 1)
		  (local.get $n)
		  )
		 (local.get $n)
		 )
		(i32.const 2)
		)
	       )
    (return
      (i32.mul
       (local.get $sumOfN)
       (local.get $sumOfN)
       )
      )
    )

  ;;
  ;; Calculate the sum of the squares of the first N natural numbers
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} The sum of the squares of the first N natural numbers
  ;;
  (func $sumOfSquares (export "sumOfSquares") (param $n i32) (result i32)
    (return ;; (/ (* (+ 1 (* 2 n)) (+ 1 n)) 6) == (2 * n + 1) * (n + 1) / 6
      (i32.div_u
       (i32.mul
	(i32.mul
	 (i32.add
	  (i32.const 1)
	  (i32.mul
	   (i32.const 2)
	   (local.get $n)
	   )
	  )
	 (i32.add
	  (i32.const 1)
	  (local.get $n)
	  )
	 )
	(local.get $n)
	)
       (i32.const 6)
       )
      )
    )

  ;;
  ;; Calculate the difference between the square of the sum and the sum of the 
  ;; squares of the first N natural numbers.
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} Difference between the square of the sum and the sum of the
  ;;                squares of the first N natural numbers.
  ;;
  (func (export "difference") (param $max i32) (result i32)
    (local $s1 i32)
    (local $s2 i32)
    (local.set $s1
	       (call $squareOfSum
		     (local.get $max)
		     )
	       )
    (local.set $s2
	       (call $sumOfSquares
		     (local.get $max)
		     )
	       )
    (return
      (i32.sub
       (select
	(local.get $s1)
	(local.get $s2)
	(i32.gt_u
	 (local.get $s1)
	 (local.get $s2)
	 )
	)
       (select
	(local.get $s1)
	(local.get $s2)
	(i32.lt_u
	 (local.get $s1)
	 (local.get $s2)
	 )
	)
       )
      )
    )
  )
