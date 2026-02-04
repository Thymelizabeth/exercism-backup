rna_transcription(Dna, Rna) :-
    string_chars(Dna, Nucleotides),
    maplist(dna_rna, Nucleotides, Mapped),
    string_chars(Rna, Mapped).

dna_rna('G', 'C').
dna_rna('C', 'G').
dna_rna('T', 'A').
dna_rna('A', 'U').