module [value]

Colour : [ Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White ]

value : Colour, Colour -> U64
value = |c1, c2|
    to_int(c1) * 10 + to_int(c2)

to_int : Colour -> U64
to_int = |colour|
    [ Black
    , Brown
    , Red
    , Orange
    , Yellow
    , Green
    , Blue
    , Violet
    , Grey
    , White
    ]
    |> List.find_first_index(|c| c == colour)
    |> Result.with_default(500)