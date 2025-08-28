class Dna(val dna: String) {
    init {
	println(nucleotideCounts)
    }

    val nucleotideCounts: Map<Char, Int>
    get() = dna
	.asIterable()
	.fold(mutableMapOf('A' to 0, 'C' to 0, 'G' to 0, 'T' to 0),
	    {acc, c ->
		acc.also({
		    acc.put(
			c,
			acc.getOrElse(
			    c,
			    {throw IllegalArgumentException("Invalid DNA Sequence")}
			).plus(1)
		    )
		})
	    }
	).toMap()
}
