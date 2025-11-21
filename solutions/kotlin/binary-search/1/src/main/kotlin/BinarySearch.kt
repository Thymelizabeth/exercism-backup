object BinarySearch {
    fun search(list: List<Int>, item: Int): Int {
        val mid = list.size / 2
        val midElem = list.getOrNull(mid) ?: throw NoSuchElementException()
        return when {
            item < midElem -> search(list.take(mid), item)
            item > midElem -> mid + 1 + search(list.subList(mid+1, list.size), item)
            else -> mid
        }
    }
}
