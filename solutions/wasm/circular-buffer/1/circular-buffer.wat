(module
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; Linear memory is allocated one page by default.
  ;; A page is 64KiB, and that can hold up to 16384 i32s.
  ;; We will permit memory to grow to a maximum of four pages.
  ;; The maximum capacity of our buffer is 65536 i32s.
  (memory (export "mem") 1 4)

  (global $write (mut i32) (i32.const 0))
  (global $read (mut i32) (i32.const 0))
  (global $capacity (mut i32) (i32.const 0))
  (global $len (mut i32) (i32.const 0))
  (global $SIZE_i32 i32 (i32.const 4))
  (global $MAX_CAPACITY i32 (i32.const 65536))

  ;;
  ;; Initialize a circular buffer of i32s with a given capacity
  ;;
  ;; @param {i32} newCapacity - capacity of the circular buffer between 0 and 65,536
  ;;                            in order to fit in four 64KiB WebAssembly pages.
  ;;
  ;; @returns {i32} 0 on success or -1 on error
  ;; 
  (func (export "init") (param $newCapacity i32) (result i32)
    (if (result i32)
      (i32.le_u
        (local.get $newCapacity)
        (global.get $MAX_CAPACITY))
      (then
        (drop
          (memory.grow
            (i32.sub
              (i32.add
                (i32.div_u
                  (i32.sub 
                    (local.get $newCapacity)
                    (i32.const 1))
                  (i32.const 16384))
                (i32.const 1))
              (memory.size))))
        (global.set $capacity
          (local.get $newCapacity))
        (i32.const 0))
      (else
        (i32.const -1)))
  )

  ;;
  ;; Clear the circular buffer
  ;;
  (func (export "clear")
    (global.set $write (i32.const 0))
    (global.set $read (i32.const 0))
    (global.set $len (i32.const 0))
  )

  ;; 
  ;; Add an element to the circular buffer
  ;;
  ;; @param {i32} elem - element to add to the circular buffer
  ;;
  ;; @returns {i32} 0 on success or -1 if full
  ;;
  (func (export "write") (param $elem i32) (result i32)
    (if (result i32)
      (i32.eq
        (global.get $capacity)
        (global.get $len))
    (then
      (i32.const -1))
    (else
      (i32.store
        (i32.mul
          (global.get $write)
          (global.get $SIZE_i32))
        (local.get $elem))
      (global.set $len
        (i32.add
          (global.get $len)
          (i32.const 1)))
      (global.set $write
        (i32.rem_u
          (i32.add
            (global.get $write)
            (i32.const 1))
          (global.get $capacity)))
      (i32.const 0)))
  )

  ;; 
  ;; Add an element to the circular buffer, overwriting the oldest element
  ;; if the buffer is full
  ;;
  ;; @param {i32} elem - element to add to the circular buffer
  ;;
  ;; @returns {i32} 0 on success or -1 if full (capacity of zero)
  ;;
  (func (export "forceWrite") (param $elem i32) (result i32)
    (if (result i32)
      (i32.eq
        (global.get $capacity)
        (i32.const 0))
    (then
      ;; Full
      (i32.const -1))
    (else
      ;; Write element
      (i32.store
        (i32.mul
          (global.get $write)
          (global.get $SIZE_i32))
        (local.get $elem))
      ;; Advance write head
      (global.set $write
        (i32.rem_u
          (i32.add
            (global.get $write)
            (i32.const 1))
          (global.get $capacity)))
      (if (result i32)
        (i32.eq
          (global.get $len)
          (global.get $capacity))
      (then
        ;; Buffer was already filled, move read head to now oldest element
        (global.set $read
          (i32.rem_u
            (i32.add
              (global.get $read)
              (i32.const 1))
            (global.get $capacity)))
        (i32.const 0))
      (else
        ;; Buffer was not filled, increment `len`
        (global.set $len
          (i32.add
            (global.get $len)
            (i32.const 1)))
        (i32.const 0)))))
  )

  ;;
  ;; Read the oldest element from the circular buffer, if not empty
  ;;
  ;; @returns {i32} element on success or -1 if empty
  ;; @returns {i32} status code set to 0 on success or -1 if empty
  ;;
  (func (export "read") (result i32 i32)
    (if (result i32 i32)
      (i32.eq
        (global.get $len)
        (i32.const 0))
    (then
      (i32.const -1)
      (i32.const -1))
    (else
      (i32.load
        (i32.mul
          (global.get $read)
          (global.get $SIZE_i32)))
      (i32.const 0)
      (global.set $len
        (i32.sub
          (global.get $len)
          (i32.const 1)))
      (global.set $read
        (i32.rem_u
          (i32.add
            (global.get $read)
            (i32.const 1))
          (global.get $capacity)))))
  )
)
