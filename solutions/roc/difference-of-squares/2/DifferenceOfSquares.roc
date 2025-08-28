module [square_of_sum, sum_of_squares, difference_of_squares]

square_of_sum : U64 -> U64
square_of_sum = |number|
    List.range({ start: At 1, end: At number })
    |> List.sum
    |> Num.pow_int(2)

sum_of_squares : U64 -> U64
sum_of_squares = |number|
    List.range({ start: At 1, end: At number })
    |> List.map(|x| Num.pow_int(x, 2))
    |> List.sum

difference_of_squares : U64 -> U64
difference_of_squares = |number|
    Num.abs_diff(sum_of_squares(number), square_of_sum(number))
