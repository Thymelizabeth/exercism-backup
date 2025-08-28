import kotlin.math.pow
object ResistorColorDuo {

    fun value(vararg colors: Color): Int = colors.take(2).map({it.ordinal}).foldIndexed(0, {i, acc, v -> acc + 10.0.pow(1 - i).toInt() * v})
}
