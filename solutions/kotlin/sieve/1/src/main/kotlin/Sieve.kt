object Sieve {

    fun primesUpTo(upperBound: Int): List<Int> = sequence {
	var current = 1
	val primes: MutableList<Int> = mutableListOf()
	val max = upperBound
	while (current++ < max) {
	    if (primes.any { current % it == 0 })
		continue
	    primes.add(current)
	    yield(current)
	}
    }.toList()
}
