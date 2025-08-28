module [to_rna]

to_rna : Str -> Str
to_rna = |dna|
    dna
    |> Str.walk_utf8("", |acc, char|
        Str.concat(acc, (when char is
            'G' -> "C"
            'C' -> "G"
            'T' -> "A"
            'A' -> "U"
            _   -> ""
            ))
            )
