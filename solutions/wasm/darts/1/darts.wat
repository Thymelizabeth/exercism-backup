(module
  ;;
  ;; Score a dart throw based on its coordinates.
  ;;
  ;; @param {f32} x - The x coordinate of the dart.
  ;; @param {f32} y - The y coordinate of the dart.
  ;;
  ;; @returns {i32} - The score of the dart throw (10, 5, 1, or 0).
  ;;
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $h f32)
    (local.set $h 
      (f32.sqrt
        (f32.add
          (f32.mul
            (local.get $x)
            (local.get $x)
          )
          (f32.mul
            (local.get $y)
            (local.get $y)
          )
        )
      )
    )

    (if (f32.le
          (local.get $h)
          (f32.const 1)
        )
    (return 
      (i32.const 10)
          )
        )
    (if (f32.le
      (local.get $h)
      (f32.const 5)
      )
    (return 
      (i32.const 5)
      )
  )
    (if (f32.le
      (local.get $h)
      (f32.const 10)
      )
  
    (return (i32.const 1)
      )
)
    (return (i32.const 0))
  )
)
