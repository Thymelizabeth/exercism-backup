module [toRna]

toRna : Str -> Str
toRna = \dna ->
    dna
    |> Str.walkUtf8 "" \acc, char ->
        Str.concat acc (when char is
            'G' -> "C"
            'C' -> "G"
            'T' -> "A"
            'A' -> "U"
            _   -> ""
            )
