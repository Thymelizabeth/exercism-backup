(module
  ;; 
  ;; Determine if a number is an Armstrong number.
  ;;
  ;; @param {i32} candidate - The number to check.
  ;;
  ;; @return {i32} 1 if the number is an Armstrong number, 0 otherwise.
  ;;
  (func (export "isArmstrongNumber") (param $candidate i32) (result i32)
    (i32.eq
     (local.get $candidate)
     (call $pow-sum-digits
	   (call $num-digits (local.get $candidate))
	   (local.get $candidate))))

  (func $num-digits (param $candidate i32) (result i32)
	(if (result i32) (i32.eq (local.get $candidate) (i32.const 0))
	    (then (return (i32.const 0)))
	    (else (return (i32.add
			   (i32.const 1)
			   (call $num-digits
				 (i32.div_u
				  (local.get $candidate)
				  (i32.const 10))))))))
  
  (func $pow-sum-digits (param $digits i32) (param $candidate i32) (result i32)
	(if (result i32) (i32.eq (local.get $candidate) (i32.const 0))
	    (then (return (i32.const 0)))
	    (else (return (i32.add
			   (call $pow
				 (i32.rem_u
				  (local.get $candidate)
				  (i32.const 10))
				 (local.get $digits))
			   (call $pow-sum-digits
				 (local.get $digits)
				 (i32.div_u
				  (local.get $candidate)
				  (i32.const 10))))))))

  (func $pow (param $self i32) (param $exp i32) (result i32)
	(if (result i32) (i32.eq (local.get $exp) (i32.const 0))
	    (then (return (i32.const 1)))
	    (else (return (i32.mul
			   (local.get $self)
			   (call $pow
				 (local.get $self)
				 (i32.sub
				  (local.get $exp)
				  (i32.const 1)))))))))
