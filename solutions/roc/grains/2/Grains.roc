module [grains_on_square, total_grains]

grains_on_square : U8 -> Result U64 _
grains_on_square = |square|
    when square is
        n if n > 64 or n == 0 -> Err OutOfRange
        n -> Num.pow_int(2, Num.int_cast(n - 1)) |> Ok

total_grains : U64
total_grains =
    List.range({ start: At 1, end: At 64 })
    |> List.map(grains_on_square)
    |> List.map(|n| Result.with_default(n, 0))
    |> List.sum
