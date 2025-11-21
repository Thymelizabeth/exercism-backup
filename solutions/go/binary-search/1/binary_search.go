package binarysearch

func SearchInts(list []int, key int) int {
	mid := len(list) / 2
    if mid >= len(list) {
        return -1
    }
    midElem := list[mid]
    switch {
        case key < midElem:
        	return SearchInts(list[:mid], key)
        case key == midElem:
        	return mid
    }
    result := SearchInts(list[mid+1:], key)
    if (result != -1) {
        result += mid + 1
    }
    return result
}
