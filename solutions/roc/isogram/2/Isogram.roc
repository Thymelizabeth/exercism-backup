module [is_isogram]

is_isogram : Str -> Bool
is_isogram = |phrase|
    phrase
    |> Str.replace_each(" ", "")
    |> Str.replace_each("-", "")
    |> Str.walk_utf8(Ok(Set.empty({})), |acc, char|
        Result.try(acc, |a|
            if Set.contains(a, to_lower(char)) then
                Err(ContainsDuplicateLetter)
            else
                Ok(Set.insert(a, to_lower(char)))
                )
                )
    |> Result.is_ok

to_lower : U8 -> U8
to_lower = |char|
    when char is
        c if c >= 'A' and c <= 'Z' -> c + 32
        _ -> char