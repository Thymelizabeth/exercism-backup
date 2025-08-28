object Pangram {

    fun isPangram(input: String): Boolean = "abcdefghijklmnopqrstuvwxyz".all(input.lowercase()::contains)
}
