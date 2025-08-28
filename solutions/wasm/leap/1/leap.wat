(module
  ;;
  ;; Determine if a year is a leap year
  ;;
  ;; @param {i32} year - The year to check
  ;;
  ;; @returns {i32} 1 if leap year, 0 otherwise
  ;;
  (func (export "isLeap") (param $year i32) (result i32)
    (i32.and
     (i32.eqz
      (i32.rem_u
       (local.get $year)
       (i32.const 4)
       )
      )
     (i32.or
      (i32.eqz ;; not
       (i32.eqz
	(i32.rem_u
	 (local.get $year)
	 (i32.const 100)
	 )
	)
       )
      (i32.eqz
       (i32.rem_u
	(local.get $year)
	(i32.const 400)
	)
       )
      )
     )
    )
  )
