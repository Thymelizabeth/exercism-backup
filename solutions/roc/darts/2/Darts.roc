module [score]

score : F64, F64 -> U64
score = |x, y|
    when Num.sqrt(x * x + y * y) is
        n if n <= 1.0 -> 10
        n if n <= 5.0 -> 5
        n if n <= 10.0 -> 1
        _ -> 0

