use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if !['A', 'C', 'G', 'T'].contains(&nucleotide) {
        Err(nucleotide)
    } else {
        dna.chars().try_fold(0, |acc, c| {
            Ok(match c {
                c if c == nucleotide => acc + 1,
                'A' | 'C' | 'G' | 'T' => acc,
                _ => return Err(c),
            })
        })
    }
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    dna.chars().try_fold(
        HashMap::from([('A', 0), ('C', 0), ('G', 0), ('T', 0)]),
        |mut acc, c| {
            match c {
                'A' | 'C' | 'G' | 'T' => acc.entry(c).and_modify(|n| *n += 1),
                _ => return Err(c),
            };
            Ok(acc)
        },
    )
}
