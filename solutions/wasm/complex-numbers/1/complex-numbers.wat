(module
  ;;
  ;; adds two complex numbers
  ;;
  ;; @param $realA {f64} - the real part of the first number
  ;; @param $imagA {f64} - the imaginary part of the first number
  ;; @param $realB {f64} - the real part of the second number
  ;; @param $imagB {f64} - the imaginary part of the second number
  ;;
  ;; @returns {(f64,f64)} - the real and imaginary parts of the complex sum
  ;;
  (func (export "add") (param $realA f64) (param $imagA f64) (param $realB f64) (param $imagB f64) (result f64 f64)
    (f64.add (local.get $realA) (local.get $realB))
    (f64.add (local.get $imagA) (local.get $imagB))
  )

  ;;
  ;; subtracts two complex numbers
  ;;
  ;; @param $realA {f64} - the real part of the first number
  ;; @param $imagA {f64} - the imaginary part of the first number
  ;; @param $realB {f64} - the real part of the second number
  ;; @param $imagB {f64} - the imaginary part of the second number
  ;;
  ;; @returns {(f64,f64)} - the real and imaginary parts of the complex difference
  ;;
  (func (export "sub") (param $realA f64) (param $imagA f64) (param $realB f64) (param $imagB f64) (result f64 f64)
    (f64.sub (local.get $realA) (local.get $realB))
    (f64.sub (local.get $imagA) (local.get $imagB))
  )

  ;;
  ;; multiplicates two complex numbers
  ;;
  ;; @param $realA {f64} - the real part of the first number
  ;; @param $imagA {f64} - the imaginary part of the first number
  ;; @param $realB {f64} - the real part of the second number
  ;; @param $imagB {f64} - the imaginary part of the second number
  ;;
  ;; @returns {(f64,f64)} - the real and imaginary parts of the complex product
  ;;
  (func (export "mul") (param $realA f64) (param $imagA f64) (param $realB f64) (param $imagB f64) (result f64 f64)
    (f64.sub
     (f64.mul (local.get $realA) (local.get $realB))
     (f64.mul (local.get $imagA) (local.get $imagB)))
    (f64.add
     (f64.mul (local.get $imagA) (local.get $realB))
     (f64.mul (local.get $realA) (local.get $imagB)))
  )

  ;;
  ;; divides two complex numbers
  ;;
  ;; @param $realA {f64} - the real part of the first number
  ;; @param $imagA {f64} - the imaginary part of the first number
  ;; @param $realB {f64} - the real part of the second number
  ;; @param $imagB {f64} - the imaginary part of the second number
  ;;
  ;; @returns {(f64,f64)} - the real and imaginary parts of the complex quotient
  ;;
  (func (export "div") (param $realA f64) (param $imagA f64) (param $realB f64) (param $imagB f64) (result f64 f64)
    (f64.div
     (f64.add
      (f64.mul (local.get $realA) (local.get $realB))
      (f64.mul (local.get $imagA) (local.get $imagB)))
     (f64.add
      (f64.mul (local.get $realB) (local.get $realB))
      (f64.mul (local.get $imagB) (local.get $imagB))))
    (f64.div
     (f64.sub
      (f64.mul (local.get $imagA) (local.get $realB))
      (f64.mul (local.get $realA) (local.get $imagB)))
     (f64.add
      (f64.mul (local.get $realB) (local.get $realB))
      (f64.mul (local.get $imagB) (local.get $imagB))))
  )

  ;;
  ;; returns the absolute of a complex number
  ;;
  ;; @param $real {f64} - the real part of the number
  ;; @param $imag {f64} - the imaginary part of the number
  ;;
  ;; @returns {f64} - the absolute of the number
  ;;
  (func (export "abs") (param $real f64) (param $imag f64) (result f64)
    (f64.sqrt 
     (f64.add
      (f64.mul (local.get $real) (local.get $real))
      (f64.mul (local.get $imag) (local.get $imag))))
  )

  ;;
  ;; returns the conjugate of a complex number
  ;;
  ;; @param $real {f64} - the real part of the number
  ;; @param $imag {f64} - the imaginary part of the number
  ;;
  ;; @returns {(f64,f64)} - the real and imaginary parts of the conjugate of the number
  ;;
  (func (export "conj") (param $real f64) (param $imag f64) (result f64 f64)
    (local.get $real)
    (f64.sub
     (f64.const 0)
     (local.get $imag))
  )

  ;;
  ;; returns the exponentiation of a complex number
  ;;
  ;; @param $real {f64} - the real part of the number
  ;; @param $imag {f64} - the imaginary part of the number
  ;;
  ;; @returns {(f64,f64}} - exponentiation of the complex number
  ;;
  (func (export "exp") (param $real f64) (param $imag f64) (result f64 f64)
    (local $expReal f64)
    (local.set $expReal
     (call $exp (local.get $real)))
    (f64.mul
     (local.get $expReal)
     (call $cos (local.get $imag)))
    (f64.mul
     (local.get $expReal)
     (call $sin (local.get $imag)))
  )

  (global $precision f64 (f64.const 26))

  (func $exp (param $x f64) (result f64)
    (local $sum f64)
    (local $n f64)
    (local $product f64)
    (local $fac f64)
    (local.set $sum (f64.const 0))
    (local.set $n (f64.const 0))
    (local.set $product (f64.const 1))
    (local.set $fac (f64.const 1))
    (loop $step
     (if 
      (f64.le
       (local.get $n)
       (global.get $precision))
      (then
       (local.set $sum
        (f64.add
         (local.get $sum)
         (f64.div
          (local.get $product)
          (local.get $fac))))
       (local.set $product
        (f64.mul
         (local.get $product)
         (local.get $x)))
       (local.set $n
        (f64.add
         (local.get $n)
         (f64.const 1)))
       (local.set $fac
        (f64.mul
         (local.get $fac)
         (local.get $n)))
       br $step)))
    (local.get $sum)
  )

  (func $cos (param $x f64) (result f64)
    (local $sum f64)
    (local $n f64)
    (local $product f64)
    (local $fac f64)
    (local.set $sum (f64.const 0))
    (local.set $n (f64.const 1))
    (local.set $product (f64.const 1))
    (local.set $fac (f64.const 1))
    (loop $step
     (if
      (f64.le
       (local.get $n)
       (global.get $precision))
      (then
       (local.set $sum
        (f64.add
         (local.get $sum)
         (f64.div
          (local.get $product)
          (local.get $fac))))
       (local.set $fac
        (f64.mul
         (local.get $fac)
         (f64.mul
          (local.get $n)
          (f64.add
           (local.get $n)
           (f64.const 1)))))
       (local.set $product
        (f64.mul
         (local.get $product)
         (f64.mul
          (f64.const -1)
          (f64.mul
           (local.get $x)
           (local.get $x)))))
       (local.set $n
        (f64.add
         (local.get $n)
         (f64.const 2)))
       br $step)))
    (local.get $sum)
  )

  (func $sin (param $x f64) (result f64)
    (f64.const 0)
  )
)
