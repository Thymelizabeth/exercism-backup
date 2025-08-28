class CustomSet(var elements: List<Int> = emptyList()) {

    constructor(v1: Int) : this(listOf(v1))
    constructor(v1: Int, v2: Int) : this(listOf(v1, v2))
    constructor(v1: Int, v2: Int, v3: Int) : this(listOf(v1, v2, v3))
    constructor(v1: Int, v2: Int, v3: Int, v4: Int) : this(listOf(v1, v2, v3, v4))

    fun isEmpty(): Boolean = elements.size == 0
    

    fun isSubset(other: CustomSet): Boolean = elements.all(other::contains)

    fun isDisjoint(other: CustomSet): Boolean = !elements.any(other::contains)
    

    fun contains(other: Int): Boolean = elements.contains(other)

    fun intersection(other: CustomSet): CustomSet = CustomSet(elements.filter(other::contains))

    fun add(other: Int) {
	val mutator = elements.toMutableList()
	mutator.add(other)
	elements = mutator.toList()
    }

    override fun equals(other: Any?): Boolean {
	if (this === other) return true
        if (other !is CustomSet) return false
	return this.isSubset(other) && other.isSubset(this)
    }

    operator fun plus(other: CustomSet): CustomSet = CustomSet(elements + other.elements)

    operator fun minus(other: CustomSet): CustomSet = CustomSet(elements.filter({!other.contains(it)}))
}
