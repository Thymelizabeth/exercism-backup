(ns leap)

(defn leap-year? [year] ;; <- argslist goes here
  ;; your code goes here
  (and (== 0 (rem year 4)) (or (not (== 0 (rem year 100))) (== 0 (rem year 400))))
)
