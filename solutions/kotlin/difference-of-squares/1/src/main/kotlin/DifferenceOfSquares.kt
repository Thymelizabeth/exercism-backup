import kotlin.math.abs;

class Squares(val n: Int) {

    fun sumOfSquares(): Int = (0..n).fold(0, {acc, x -> x * x + acc})

    fun squareOfSum(): Int = {x: Int -> x * x}((0..n).sum())

    fun difference(): Int = abs(sumOfSquares() - squareOfSum())
}
