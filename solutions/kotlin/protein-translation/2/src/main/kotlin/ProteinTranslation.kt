fun translate(rna: String?): List<String> = if (rna == null)
						emptyList()
						else
						rna.chunkedSequence(3).map({when (it) {
						    "AUG" -> "Methionine"
						    "UUU", "UUC" -> "Phenylalanine"
						    "UUA", "UUG" -> "Leucine"
						    "UCU", "UCC", "UCA", "UCG" -> "Serine"
						    "UAU", "UAC" -> "Tyrosine"
						    "UGU", "UGC" -> "Cysteine"
						    "UGG" -> "Tryptophan"
						    "UAA", "UAG", "UGA" -> "STOP"
						    else -> throw IllegalArgumentException("Invalid codon")
						}}).takeWhile({it != "STOP"}).toList()
