rna_transcription(Dna, Rna) :-
    string_chars(Dna, Nucleotides),
    maplist([X, Y]>>
    ( X = 'G'
    -> Y = 'C'
    ; X = 'C'
    -> Y = 'G'
    ; X = 'T'
    -> Y = 'A'
    ; X = 'A'
    -> Y = 'U'
    ; fail), Nucleotides, Mapped),
    string_chars(Rna, Mapped).
