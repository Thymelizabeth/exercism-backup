
enum class Classification {
    DEFICIENT, PERFECT, ABUNDANT
}

fun classify(n: Int): Classification = if (n <= 0) throw IllegalArgumentException() else when (n.factors().sum().minus(n)) {
    in Int.MIN_VALUE..-1 -> Classification.DEFICIENT
    0 -> Classification.PERFECT
    else -> Classification.ABUNDANT
}

fun Int.factors(): List<Int> =
    (1..this - 1).filter {this % it == 0}.toList()
