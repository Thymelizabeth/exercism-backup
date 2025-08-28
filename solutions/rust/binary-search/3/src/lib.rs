use std::cmp::Ordering;
pub fn find<T: Ord + Clone>(array: impl AsRef<[T]>, key: T) -> Option<usize> {
    let mid = array.as_ref().len() / 2;
    array.as_ref().get(mid).and_then(|x| match key.cmp(x) {
        Ordering::Less => find(&array.as_ref()[0..mid], key),
        Ordering::Equal => Some(mid),
        Ordering::Greater => find(&array.as_ref()[mid + 1..], key).map(|i| i + mid + 1),
    })
}
