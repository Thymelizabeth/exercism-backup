object Raindrops {

    fun convert(n: Int): String {
	val result = StringBuilder()
	if (n.mod(3) == 0)
	    result.append("Pling")
	if (n.mod(5) == 0)
	    result.append("Plang")
	if (n.mod(7) == 0)
	    result.append("Plong")
	return if (result.isEmpty()) "$n" else result.toString()
    }
}
