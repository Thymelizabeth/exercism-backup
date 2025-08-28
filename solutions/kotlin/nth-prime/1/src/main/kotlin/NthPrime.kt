object Prime {

    fun nth(n: Int): Int = if (n < 1) throw IllegalArgumentException("There is no zeroth prime.") else sequence {
	var current = 1
	val primes: MutableList<Int> = mutableListOf()
	while (true) {
	    current++
	    if (primes.any { current % it == 0 })
		continue
	    primes.add(current)
	    yield(current)
	}
    }.drop(n - 1).first()
}

