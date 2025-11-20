(module
    (memory (export "mem") 1)

    (global $error i32 (i32.const -1))
    (global $north i32 (i32.const 0))
    (global $east i32 (i32.const 1))
    (global $south i32 (i32.const 2))
    (global $west i32 (i32.const 3))
    (global $advance i32 (i32.const 65)) ;; 'A'
    (global $left i32 (i32.const 76)) ;; 'L'
    (global $right i32 (i32.const 82)) ;; 'R'

    ;;
    ;; evaluate robot placement after running instructions
    ;;
    ;; @param {i32} $direction - 0 = north, 1 = east, 2 = south, 3 = west
    ;; @param {i32} $x - horizontal position
    ;; @param {i32} $y - vertical position
    ;; @param {i32} $offset - the offset of the instructions in linear memory
    ;; @param {i32} $length - the length of the instructions in linear memory
    ;;
    ;; @returns {(i32,i32,i32)} direction, x and y after the instructions
    ;;          direction is -1 on error
    ;;
    (func $evaluate (export "evaluate") (param $direction i32) (param $x i32) (param $y i32)
        (param $offset i32) (param $length i32) (result i32 i32 i32)
        (local $instr i32)
        (if (result i32 i32 i32)
          (i32.eq
            (local.get $length)
            (i32.const 0))
        (then
          (local.get $direction) (local.get $x) (local.get $y))
        (else
          (local.set $instr
            (i32.load8_u
              (local.get $offset)))
          (if (result i32 i32 i32)
            (i32.eq
              (local.get $instr)
              (global.get $advance))
          (then
            ;; 'A'
            (call $evaluate
              (local.get $direction)
              (call $advance_x
                (local.get $x)
                (local.get $direction))
              (call $advance_y
                (local.get $y)
                (local.get $direction))
              (i32.add
                (local.get $offset)
                (i32.const 1))
              (i32.sub
                (local.get $length)
                (i32.const 1))))
          (else (if (result i32 i32 i32)
            (i32.eq
              (local.get $instr)
              (global.get $left))
          (then
            ;; 'L'
            (call $evaluate
              (call $turn_left
                (local.get $direction))
              (local.get $x)
              (local.get $y)
              (i32.add
                (local.get $offset)
                (i32.const 1))
              (i32.sub
                (local.get $length)
                (i32.const 1))))
          (else (if (result i32 i32 i32)
            (i32.eq
              (local.get $instr)
              (global.get $right))
          (then
            ;; 'R'
            (call $evaluate
              (call $turn_right
                (local.get $direction))
              (local.get $x)
              (local.get $y)
              (i32.add
                (local.get $offset)
                (i32.const 1))
              (i32.sub
                (local.get $length)
                (i32.const 1))))
          (else
            ;; error
            (global.get $error)
            (local.get $x)
            (local.get $y)))))))))
    )
    
    ;; Returns the new x-value depending on the old x-value and the direction to advance
    (func $advance_x (param $x i32) (param $direction i32) (result i32)
      (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $east))
      (then
        (i32.add
          (local.get $x)
          (i32.const 1)))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $west))
      (then
        (i32.sub
          (local.get $x)
          (i32.const 1)))
      (else
        (local.get $x)))))
    )
    
    ;; Returns the new y-value depending on the old y-value and the direction to advance
    (func $advance_y (param $y i32) (param $direction i32) (result i32)
      (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $north))
      (then
        (i32.add
          (local.get $y)
          (i32.const 1)))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $south))
      (then
        (i32.sub
          (local.get $y)
          (i32.const 1)))
      (else
        (local.get $y)))))
    )
    
    ;; Returns the new direction depending on the old direction (turning left)
    (func $turn_left (param $direction i32) (result i32)
      (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $north))
      (then
        (global.get $west))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $west))
      (then
        (global.get $south))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $south))
      (then
        (global.get $east))
      (else
        (global.get $north)))))))
    )

    ;; Returns the new direction depending on the old direction (turning right)
    (func $turn_right (param $direction i32) (result i32)
      (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $north))
      (then
        (global.get $east))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $east))
      (then
        (global.get $south))
      (else (if (result i32)
        (i32.eq
          (local.get $direction)
          (global.get $south))
      (then
        (global.get $west))
      (else
        (global.get $north)))))))
    )
)