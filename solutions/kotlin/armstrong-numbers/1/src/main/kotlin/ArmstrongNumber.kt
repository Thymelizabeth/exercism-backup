import kotlin.math.pow
object ArmstrongNumber {

    fun check(input: Int): Boolean = input == digits(input).map({it.toDouble().pow(digits(input).size)}).sum().toInt()

    fun digits(input: Int): List<Int> = if (input < 10) listOf(input.mod(10)) else listOf(input.mod(10)).plus(digits(input.div(10)))

}
