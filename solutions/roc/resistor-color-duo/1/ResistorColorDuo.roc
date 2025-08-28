module [value]

value : List Str -> Result U64 _
value = \colors ->
    when colors is
        [] | [_] -> Err NotEnoughColours
        [c1, c2, ..] -> Ok (toInt c1 * 10 + toInt c2)

toInt : Str -> U64
toInt = \colour ->
    [ "black"
    , "brown"
    , "red"
    , "orange"
    , "yellow"
    , "green"
    , "blue"
    , "violet"
    , "grey"
    , "white"]
    |> List.findFirstIndex \c -> c == colour
    |> Result.withDefault 500