object Raindrops {

    val raindropTranslator = sortedMapOf(3 to "Pling", 5 to "Plang", 7 to "Plong")
    fun convert(n: Int): String {
	val result = StringBuilder()
	raindropTranslator.forEach({k, v -> if (n.mod(k) == 0) result.append(v)})
	return if (result.isEmpty()) "$n" else result.toString()
    }
}
