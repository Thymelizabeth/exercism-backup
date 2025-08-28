import kotlin.math.cos
import kotlin.math.pow
import kotlin.math.sin
import kotlin.math.sqrt
import kotlin.math.E

data class ComplexNumber(val real: Double = 0.0, val imag: Double = 0.0) {
    operator fun plus(other: ComplexNumber) = ComplexNumber(real + other.real, imag + other.imag)
    operator fun minus(other: ComplexNumber) = ComplexNumber(real - other.real, imag - other.imag)
    operator fun times(other: ComplexNumber) = ComplexNumber(real * other.real - imag * other.imag, imag * other.real + real * other.imag)
    operator fun div(other: ComplexNumber) = ComplexNumber((real * other.real + imag * other.imag).div(other.real * other.real + other.imag * other.imag), (imag * other.real - real * other.imag).div(other.real * other.real + other.imag * other.imag))
    fun conjugate() = ComplexNumber(real, -imag)
    val abs = sqrt(real * real + imag * imag)
}

fun exponential(z: ComplexNumber) = ComplexNumber(real = E.pow(z.real)) * ComplexNumber(cos(z.imag), sin(z.imag))
