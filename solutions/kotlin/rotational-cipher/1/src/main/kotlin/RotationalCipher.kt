class RotationalCipher(val rotation: Int) {

    fun encode(text: String): String = text.asIterable().map({when {
	!it.isLetter() -> it
	it + rotation % 26 > 'Z' && it.isUpperCase() || it + rotation % 26 > 'z' && it.isLowerCase() -> it.plus(rotation.mod(26)).minus(26)
	else -> it.plus(rotation.mod(26))
    }
    }).joinToString("")
}
