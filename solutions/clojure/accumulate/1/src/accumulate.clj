(ns accumulate)

(defn accumulate [f vs]
  (if (not-empty vs)
    (cons (f (first vs)) (accumulate f (drop 1 vs)))
    [])
)
