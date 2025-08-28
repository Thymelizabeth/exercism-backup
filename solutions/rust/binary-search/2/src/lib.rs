use std::cmp::Ordering;
pub fn find<T: Ord, Eq>(array: &[T], key: T) -> Option<usize> {
    let mid = array.len() / 2;
    array.get(mid).and_then(|x| match key.cmp(x) {
        Ordering::Less => find(&array[0..mid], key),
        Ordering::Equal => Some(mid),
        Ordering::Greater => find(&array[mid + 1..], key).map(|i| i + mid + 1),
    })
}
