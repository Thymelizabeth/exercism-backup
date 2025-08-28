class Deque<T> {
    var start: Node<T>? = null
    var end: Node<T>? = null

    fun push(value: T) {
	val oldStart = start
	val newStart = Node<T>(value, next = oldStart)
	oldStart?.prev = newStart
	start = newStart
	if (end == null)
	    end = start
    }

    fun pop(): T? {
	val oldStart = start
	start = oldStart?.next
	start?.prev = null
	return oldStart?.value
    }

    fun unshift(value: T) {
	val oldEnd = end
	val newEnd = Node<T>(value, prev = oldEnd)
	oldEnd?.next = newEnd
	end = newEnd
	if (start == null)
	    start = end
    }

    fun shift(): T? {
	val oldEnd = end
	end = end?.prev
	end?.next = null
	return oldEnd?.value
    }

    data class Node<T>(val value: T, var next: Node<T>? = null, var prev: Node<T>? = null)
}
