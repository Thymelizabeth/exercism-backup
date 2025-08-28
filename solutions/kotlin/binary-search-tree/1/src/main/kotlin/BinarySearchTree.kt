import kotlin.math.pow

class BinarySearchTree<T : Comparable<T>> {

    data class Node<T>(
	val data: T,
	var left: Node<T>? = null,
	var right: Node<T>? = null,
    )

    var root: Node<T>? = null

    fun insert(value: T) {
        root = insertR(value, root)
    }

    fun insertR(value: T, cRoot: Node<T>?): Node<T> {
	if (cRoot == null) {
	    return Node(value)
	}
	if (value <= cRoot.data) {
	    cRoot.left = insertR(value, cRoot.left)
	} else {
	    cRoot.right = insertR(value, cRoot.right)	    
	}
	return cRoot
    }

    fun asSortedList(cRoot: Node<T>? = root): List<T> {
	if (cRoot == null)
	    return emptyList<T>()
	return asSortedList(cRoot.left) + cRoot.data + asSortedList(cRoot.right)
    }

    fun asLevelOrderList(): List<T> {
        val depth: Int = depth()
	if (depth < 1)
	    return emptyList()
	var result: MutableList<Node<T>?> = MutableList(2.0.pow(depth).toInt() - 1, {null})
	result[0] = root
	for (i in 0..2.0.pow(depth - 1).toInt() - 2) {
	    if (result[i] == null)
		continue
	    result[2 * i + 1] = result[i]?.left
	    result[2 * i + 2] = result[i]?.right
	}
	return result.filterNotNull().map {it.data}
    }

    fun depth(cRoot: Node<T>? = root): Int = when (cRoot) {
	null -> 0
	else -> 1 + maxOf(depth(cRoot.left), depth(cRoot.right))
    }

}
