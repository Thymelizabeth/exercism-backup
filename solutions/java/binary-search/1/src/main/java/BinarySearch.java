import java.util.List;

class BinarySearch {
    List<Integer> items;
    
    BinarySearch(List<Integer> items) {
        this.items = items;
    }

    int indexOf(int item) throws ValueNotFoundException {
        if (items.size() == 0) {
            throw new ValueNotFoundException("Value not in array");
        }
        int mid = items.size() / 2;
        Integer midElem = items.get(mid);
        if (item < midElem) {
            BinarySearch rec = new BinarySearch(items.subList(0, mid));
            return rec.indexOf(item);
        } else if (item > midElem) {
            BinarySearch rec = new BinarySearch(items.subList(mid + 1, items.size()));
            return rec.indexOf(item) + mid + 1;
        } else {
            return mid;
        }
    }
}
