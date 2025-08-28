def proteins(strand):
    proteins_dict: dict = {
        "AUG": "Methionine",
        "UUU": "Phenylalanine",
        "UUC": "Phenylalanine",
        "UUA": "Leucine",
        "UUG": "Leucine",
        "UCU": "Serine",
        "UCC": "Serine",
        "UCA": "Serine",
        "UCG": "Serine",
        "UAU": "Tyrosine",
        "UAC": "Tyrosine",
        "UGU": "Cysteine",
        "UGC": "Cysteine",
        "UGG": "Tryptophan",
    }
    result = []
    for i in range(0, len(strand), 3):
        protein = strand[i:i+3]
        if protein in proteins_dict:
            result.append(proteins_dict[protein])
        else:
            break
    return result