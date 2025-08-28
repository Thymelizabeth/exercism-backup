module [squareOfSum, sumOfSquares, differenceOfSquares]

squareOfSum : U64 -> U64
squareOfSum = \number ->
    List.range { start: At 1, end: At number }
    |> List.sum
    |> Num.powInt 2

sumOfSquares : U64 -> U64
sumOfSquares = \number ->
    List.range { start: At 1, end: At number }
    |> List.map (\x -> Num.powInt x 2)
    |> List.sum

differenceOfSquares : U64 -> U64
differenceOfSquares = \number ->
    Num.absDiff (sumOfSquares number) (squareOfSum number)
