module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } [InvalidNucleotide U8]
nucleotide_counts = |input|
    Str.walk_utf8(
        input,
        Ok { a: 0, c: 0, g: 0, t: 0 },
        |result, nucleotide|
            Result.try(
                result,
                |acc|
                    when nucleotide is
                        'A' -> Ok { acc & a: acc.a + 1 }
                        'C' -> Ok { acc & c: acc.c + 1 }
                        'G' -> Ok { acc & g: acc.g + 1 }
                        'T' -> Ok { acc & t: acc.t + 1 }
                        _ -> Err (InvalidNucleotide nucleotide),
            ),
    )
