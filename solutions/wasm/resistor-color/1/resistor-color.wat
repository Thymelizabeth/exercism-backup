(module
  (memory (export "mem") 1)
  
  (data (i32.const 100) "black,brown,red,orange,yellow,green,blue,violet,grey,white")
  (global $total_len i32 (i32.const 58))
  (global $black i32 (i32.const 100))
  (global $black_len i32 (i32.const 5))
  (global $brown i32 (i32.const 106))
  (global $brown_len i32 (i32.const 5))
  (global $red i32 (i32.const 112))
  (global $red_len i32 (i32.const 3))
  (global $orange i32 (i32.const 116))
  (global $orange_len i32 (i32.const 6))
  (global $yellow i32 (i32.const 123))
  (global $yellow_len i32 (i32.const 6))
  (global $green i32 (i32.const 130))
  (global $green_len i32 (i32.const 5))
  (global $blue i32 (i32.const 136))
  (global $blue_len i32 (i32.const 4))
  (global $violet i32 (i32.const 141))
  (global $violet_len i32 (i32.const 6))
  (global $grey i32 (i32.const 148))
  (global $grey_len i32 (i32.const 4))
  (global $white i32 (i32.const 153))
  (global $white_len i32 (i32.const 5))
  (global $true i32 (i32.const 1))
  (global $false i32 (i32.const 0))

  ;;
  ;; Return buffer of comma separated colors
  ;; "black,brown,red,orange,yellow,green,blue,violet,grey,white"
  ;;
  ;; @returns {(i32, i32)} - The offset and length of the buffer of comma separated colors
  ;;
  (func (export "colors") (result i32 i32)
    (return (global.get $black) (global.get $total_len))
  )

  ;;
  ;; Given a valid resistor color, returns the associated value
  ;;
  ;; @param {i32} offset - offset into the color buffer
  ;; @param {i32} len - length of the color string
  ;;
  ;; @returns {i32} - the associated value
  ;;
  (func (export "colorCode") (param $offset i32) (param $len i32) (result i32)
    (if (result i32)
      (call $eql (global.get $black) (global.get $black_len) (local.get $offset) (local.get $len))
    (then (i32.const 0))
    (else (if (result i32)
      (call $eql (global.get $brown) (global.get $brown_len) (local.get $offset) (local.get $len))
    (then (i32.const 1))
    (else (if (result i32)
      (call $eql (global.get $red) (global.get $red_len) (local.get $offset) (local.get $len))
    (then (i32.const 2))
    (else (if (result i32)
      (call $eql (global.get $orange) (global.get $orange_len) (local.get $offset) (local.get $len))
    (then (i32.const 3))
    (else (if (result i32)
      (call $eql (global.get $yellow) (global.get $yellow_len) (local.get $offset) (local.get $len))
    (then (i32.const 4))
    (else (if (result i32)
      (call $eql (global.get $green) (global.get $green_len) (local.get $offset) (local.get $len))
    (then (i32.const 5))
    (else (if (result i32)
      (call $eql (global.get $blue) (global.get $blue_len) (local.get $offset) (local.get $len))
    (then (i32.const 6))
    (else (if (result i32)
      (call $eql (global.get $violet) (global.get $violet_len) (local.get $offset) (local.get $len))
    (then (i32.const 7))
    (else (if (result i32)
      (call $eql (global.get $grey) (global.get $grey_len) (local.get $offset) (local.get $len))
    (then (i32.const 8))
    (else (if (result i32)
      (call $eql (global.get $white) (global.get $white_len) (local.get $offset) (local.get $len))
    (then (i32.const 9))
    (else (i32.const -1)))))))))))))))))))))
  )

  (func $eql (param $offset_a i32) (param $len_a i32) (param $offset_b i32) (param $len_b i32) (result i32)
    (if (result i32)
      (i32.eq
        (local.get $len_a)
        (i32.const 0))
    (then
      (if (result i32)
        (i32.eq
          (local.get $len_b)
          (i32.const 0))
      (then
        (global.get $true))
      (else
        (global.get $false))))
    (else
      (if (result i32)
        (i32.eq
          (local.get $len_b)
          (i32.const 0))
      (then
        (global.get $false))
      (else
        (if (result i32)
          (i32.ne
            (i32.load8_u (local.get $offset_a))
            (i32.load8_u (local.get $offset_b)))
        (then
          (global.get $false))
        (else
          (call $eql
            (i32.add
              (local.get $offset_a)
              (i32.const 1))
            (i32.sub
              (local.get $len_a)
              (i32.const 1))
            (i32.add
              (local.get $offset_b)
              (i32.const 1))
            (i32.sub
              (local.get $len_b)
              (i32.const 1)))))))))
  )
)
