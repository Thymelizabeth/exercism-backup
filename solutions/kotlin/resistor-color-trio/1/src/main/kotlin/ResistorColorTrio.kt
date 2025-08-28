import kotlin.math.pow
object ResistorColorTrio {

    fun text(vararg input: Color): String {
        var value = input.take(2).map({it.ordinal}).foldIndexed(0, {i, acc, v -> acc + 10.0.pow(1 - i).toInt() * v}) * 10.0.pow(input.get(2).ordinal).toInt()
	val unit: Unit = when (value) {
	    in 0.rangeUntil(10.0.pow(3).toInt()) -> Unit.OHMS
	    in 0.rangeUntil(10.0.pow(6).toInt()) -> Unit.KILOOHMS
	    in 0.rangeUntil(10.0.pow(9).toInt()) -> Unit.MEGAOHMS
	    in 0.rangeUntil(10.0.pow(12).toInt()) -> Unit.GIGAOHMS
	    else -> Unit.TERAOHMS
	}
	return when (unit) {
	    Unit.OHMS -> "$value ohms"
	    Unit.KILOOHMS -> "${value.div(1000)} kiloohms"
	    Unit.MEGAOHMS -> "${value.div(10.0.pow(6).toInt())} megaohms"
	    else -> "${value.div(10.0.pow(9).toInt())} gigaohms"
	}
    }
}
