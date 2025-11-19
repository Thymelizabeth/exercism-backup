(module
  (memory (export "mem") 1)

  ;;
  ;; Truncate UTF-8 input string to 5 characters (UTF-8 codepoints)
  ;;
  ;; @param {i32} offset - The offset of the input string in linear memory
  ;; @param {i32} length - The length of the input string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the truncated string in linear memory
  ;;
  (func (export "truncate") (param $offset i32) (param $length i32) (result i32 i32)
    (return
      (local.get $offset) 
      (call $first_5_char_length (local.get $offset) (local.get $length) (i32.const 0) (i32.const 0)))
  )

  (func $first_5_char_length (param $offset i32) (param $length i32) (param $acc_chars i32) (param $acc_bytes i32) (result i32)
    (if (result i32)
      (i32.or
        (i32.le_s (local.get $length) (i32.const 0))
        (i32.eq (local.get $acc_chars) (i32.const 5)))
      (then
        (local.get $acc_bytes))
      (else (if (result i32)
        (i32.eq 
          (i32.and
            (i32.load8_u (local.get $offset))
            (i32.const 0x80))
          (i32.const 0x00))
      (then 
        (call $first_5_char_length
          (i32.add (local.get $offset) (i32.const 1))
          (i32.sub (local.get $length) (i32.const 1))
          (i32.add (local.get $acc_chars) (i32.const 1))
          (i32.add (local.get $acc_bytes) (i32.const 1))))
      (else (if (result i32)
        (i32.eq
          (i32.and
            (i32.load8_u (local.get $offset))
            (i32.const 0xE0))
          (i32.const 0xC0))
      (then
        (call $first_5_char_length
          (i32.add (local.get $offset) (i32.const 2))
          (i32.sub (local.get $length) (i32.const 2))
          (i32.add (local.get $acc_chars) (i32.const 1))
          (i32.add (local.get $acc_bytes) (i32.const 2))))
      (else (if (result i32)
        (i32.eq
          (i32.and
            (i32.load8_u (local.get $offset))
            (i32.const 0xF0))
        (i32.const 0xE0))
      (then
        (call $first_5_char_length
          (i32.add (local.get $offset) (i32.const 3))
          (i32.sub (local.get $length) (i32.const 3))
          (i32.add (local.get $acc_chars) (i32.const 1))
          (i32.add (local.get $acc_bytes) (i32.const 3))))
      (else
        (call $first_5_char_length
          (i32.add (local.get $offset) (i32.const 4))
          (i32.sub (local.get $length) (i32.const 4))
          (i32.add (local.get $acc_chars) (i32.const 1))
          (i32.add (local.get $acc_bytes) (i32.const 4)))))))))))
  )
)
