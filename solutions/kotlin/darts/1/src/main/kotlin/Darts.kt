import kotlin.math.sqrt
import kotlin.math.pow
object Darts {

    fun score(x: Number, y: Number): Int =
        when (sqrt(x.toDouble().pow(2) + y.toDouble().pow(2))) {
	    in 0.0..1.0 -> 10
	    in 0.0..5.0 -> 5
	    in 0.0..10.0 -> 1
	    else -> 0
	}
}
