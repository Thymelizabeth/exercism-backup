(module
  ;;
  ;; Return the number of steps needed to reach 1 in the Collatz conjecture.
  ;;
  ;; @param {i32} number - The number to start from.
  ;;
  ;; @returns {i32} - The number of steps needed to reach 1.
  ;;
  (func (export "steps") (param $number i32) (result i32)
    (if (result i32)
      (i32.le_s (local.get $number) (i32.const 0))
      (then
        (i32.const -1))
      (else
	    (call $collatz (local.get $number) (i32.const 0))))
  )

  (func $collatz (param $number i32) (param $acc i32) (result i32)
    (if (result i32)
      (i32.eq
        (local.get $number)
        (i32.const 1))
    (then
      (local.get $acc))
    (else (if (result i32)
      (i32.eq
        (i32.rem_u
          (local.get $number)
          (i32.const 2))
        (i32.const 0))
    (then
      (call $collatz
        (i32.div_u 
          (local.get $number)
          (i32.const 2))
        (i32.add
          (local.get $acc)
          (i32.const 1))))
    (else
      (call $collatz
        (i32.add
          (i32.const 1)
          (i32.mul
            (local.get $number)
            (i32.const 3)))
        (i32.add
          (local.get $acc)
          (i32.const 1)))))))
  )
)