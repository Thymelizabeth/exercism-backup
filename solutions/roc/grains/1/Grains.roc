module [grainsOnSquare, totalGrains]

grainsOnSquare : U8 -> Result U64 _
grainsOnSquare = \square ->
    when square is
        n if n > 64 || n == 0 -> Err OutOfRange
        n -> Num.powInt 2 (Num.intCast n - 1) |> Ok

totalGrains : U64
totalGrains =
    List.range { start: At 1, end: At 64 }
    |> List.map grainsOnSquare
    |> List.map \n -> Result.withDefault n 0
    |> List.sum
