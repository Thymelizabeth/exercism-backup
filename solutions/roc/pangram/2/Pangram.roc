module [is_pangram]

is_pangram : Str -> Bool
is_pangram = |sentence|
    "abcdefghijklmnopqrstuvwxyz"
    |> Str.to_utf8
    |> Set.from_list
    |> Set.intersection(sentence |> Str.to_utf8 |> Set.from_list |> Set.map(to_lowercase))
    |> Set.len
    |> Bool.is_eq(26)

to_lowercase : U8 -> U8
to_lowercase = |char|
    when char is
        c if c >= 'A' && c <= 'Z' -> c + 32
        _ -> char