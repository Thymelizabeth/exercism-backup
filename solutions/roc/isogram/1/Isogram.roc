module [isIsogram]

isIsogram : Str -> Bool
isIsogram = \phrase ->
    phrase
    |> Str.replaceEach " " ""
    |> Str.replaceEach "-" ""
    |> Str.walkUtf8 (Ok (Set.empty {})) \acc, char ->
        Result.try acc \a ->
            if Set.contains a (toLower char) then
                Err ContainsDuplicateLetter
            else
                Set.insert a (toLower char) |> Ok
    |> Result.isOk

toLower : U8 -> U8
toLower = \char ->
    when char is
        c if c >= 'A' && c <= 'Z' -> c + 32
        _ -> char