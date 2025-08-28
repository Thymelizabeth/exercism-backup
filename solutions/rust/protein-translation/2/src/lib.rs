pub fn translate(rna: &str) -> Option<Vec<&str>> {
    rna.chars()
        .collect::<Vec<_>>()
        .chunks(3)
        .take_while(|c| !matches!(c, &['U', 'A', 'A'] | &['U', 'A', 'G'] | &['U', 'G', 'A']))
        .try_fold(Vec::new(), |mut acc, protein| {
            acc.push(match protein.iter().collect::<String>().as_str() {
                "AUG" => "Methionine",
                "UUU" | "UUC" => "Phenylalanine",
                "UUA" | "UUG" => "Leucine",
                "UCU" | "UCC" | "UCA" | "UCG" => "Serine",
                "UAU" | "UAC" => "Tyrosine",
                "UGU" | "UGC" => "Cysteine",
                "UGG" => "Tryptophan",
                _ => return None,
            });
            Some(acc)
        })
}
