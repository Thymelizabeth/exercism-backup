module [isPangram]

isPangram : Str -> Bool
isPangram = \sentence ->
    "abcdefghijklmnopqrstuvwxyz"
    |> Str.toUtf8
    |> Set.fromList
    |> Set.intersection (sentence |> Str.toUtf8 |> Set.fromList |> Set.map toLowercase)
    |> Set.len
    |> Bool.isEq 26

toLowercase : U8 -> U8
toLowercase = \char ->
    when char is
        c if c >= 'A' && c <= 'Z' -> c + 32
        _ -> char