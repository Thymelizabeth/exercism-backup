object Raindrops {

    val raindropTranslator: Map<Int, String> = mapOf(3 to "Pling", 5 to "Plang", 7 to "Plong")
    fun convert(n: Int): String {
	val result = StringBuilder()
	raindropTranslator.toSortedMap().forEach({k, v -> if (n.mod(k) == 0) result.append(v)})
	return if (result.isEmpty()) "$n" else result.toString()
    }
}
