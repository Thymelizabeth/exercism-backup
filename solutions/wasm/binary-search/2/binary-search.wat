(module
  (memory (export "mem") 1)
 
  ;;
  ;; Find the first occurrence of the needle in the haystack
  ;;
  ;; @param {i32} base - the base address of the haystack
  ;; @param {i32} nelems - the number of elements in the haystack
  ;; @param {i32} needle - the value to search for
  ;;
  ;; @return {i32} the index of the first occurrence of the needle in the haystack
  ;;               or -1 if the needle is not found.
  ;;
  (func $find (export "find") (param $base i32) (param $nelems i32) (param $needle i32) (result i32)
    (local $middle_elem i32) (local $middle i32) (local $result i32)
    (if (result i32)
      (i32.eq
        (i32.const 0)
        (local.get $nelems))
    (then
      (i32.const -1)) ;; No elements in haystack
    (else
      (local.set $middle
        (i32.div_u
          (i32.sub
            (local.get $nelems)
            (i32.const 1))
          (i32.const 2))) ;; middle = (nelems - 1) / 2
      (local.set $middle_elem
        (i32.load
          (i32.add
            (local.get $base)
            (i32.mul
              (local.get $middle)
              (i32.const 4))))) ;; middle_elem = base[middle] ;; `base` is array of i32, so multiply `middle` by 4
      (if (result i32)
        (i32.eq
          (local.get $needle)
          (local.get $middle_elem))
      (then
        (local.get $middle)) ;; Found `needle`
      (else (if (result i32)
        (i32.lt_u
          (local.get $needle)
          (local.get $middle_elem))
      (then
        (call $find
          (local.get $base)
          (local.get $middle)
          (local.get $needle))) ;; Search lower half of array
      (else
        (local.set $result
          (call $find
            (i32.add
              (local.get $base)
              (i32.mul 
                (i32.add 
                  (local.get $middle)
                  (i32.const 1))
                (i32.const 4))) ;; Start from base[middle + 1]
            (i32.sub
              (local.get $nelems)
              (i32.add
                (local.get $middle)
                (i32.const 1)))
            (local.get $needle)))
          (i32.add
            (if (result i32)
              (i32.eq
                (local.get $result)
                (i32.const -1)) ;; Only add `middle` to `result` if `result` indicates that `needle` was found
              (then 
                (i32.const 0))
              (else
                (i32.add
                  (local.get $middle)
                  (i32.const 1))))
            (local.get $result))))))))
  )
)
