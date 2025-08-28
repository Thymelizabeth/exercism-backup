object Isogram {

    fun isIsogram(input: String): Boolean {
	val filteredInput = input.lowercase().filterNot {it == ' ' || it == '-'}
	return filteredInput.toSet().size == filteredInput.length
    }
}
