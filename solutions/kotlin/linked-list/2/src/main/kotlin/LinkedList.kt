class Deque<T> {
    val elements: MutableList<T> = mutableListOf()

    fun push(value: T) = elements.add(value)

    fun pop(): T? = elements.removeLastOrNull()

    fun unshift(value: T) = elements.add(0, value)

    fun shift(): T? = elements.removeFirstOrNull()
}
