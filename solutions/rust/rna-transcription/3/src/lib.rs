#[derive(Debug, PartialEq, Eq)]
pub struct Dna(Vec<NucleotideDNA>);

#[derive(Debug, PartialEq, Eq)]
pub struct Rna(Vec<NucleotideRNA>);

#[derive(Debug, PartialEq, Eq)]
enum NucleotideDNA {
    A,
    C,
    G,
    T,
}

#[derive(Debug, PartialEq, Eq)]
enum NucleotideRNA {
    A,
    C,
    G,
    U,
}

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        Ok(Dna(dna.char_indices().try_fold(
            Vec::with_capacity(dna.len()),
            |mut acc, (i, c)| {
                acc.push(match c {
                    'A' => NucleotideDNA::A,
                    'C' => NucleotideDNA::C,
                    'G' => NucleotideDNA::G,
                    'T' => NucleotideDNA::T,
                    _ => return Err(i),
                });
                Ok(acc)
            },
        )?))
    }

    pub fn into_rna(self) -> Rna {
        Rna(self
            .0
            .into_iter()
            .map(|nucleotide| match nucleotide {
                NucleotideDNA::A => NucleotideRNA::U,
                NucleotideDNA::C => NucleotideRNA::G,
                NucleotideDNA::G => NucleotideRNA::C,
                NucleotideDNA::T => NucleotideRNA::A,
            })
            .collect())
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        Ok(Rna(rna.char_indices().try_fold(
            Vec::with_capacity(rna.len()),
            |mut acc, (i, c)| {
                acc.push(match c {
                    'A' => NucleotideRNA::A,
                    'C' => NucleotideRNA::C,
                    'G' => NucleotideRNA::G,
                    'U' => NucleotideRNA::U,
                    _ => return Err(i),
                });
                Ok(acc)
            },
        )?))
    }
}
