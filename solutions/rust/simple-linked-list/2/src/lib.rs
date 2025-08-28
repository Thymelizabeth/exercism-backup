pub struct SimpleLinkedList<T> {
    head: Link<T>,
}

type Link<T> = Option<Box<Node<T>>>;

struct Node<T> {
    value: T,
    next: Link<T>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for SimpleLinkedList)
    pub fn is_empty(&self) -> bool {
        self.head.is_none()
    }

    pub fn len(&self) -> usize {
        let mut cur = self.head.as_ref();
        let mut i = 0;
        while cur.is_some() {
            cur = cur.unwrap().next.as_ref();
            i += 1;
        }
        i
    }

    pub fn push(&mut self, value: T) {
        let old_head = self.head.take();
        self.head = Some(Box::new(Node {
            value,
            next: old_head,
        }));
    }

    pub fn pop(&mut self) -> Option<T> {
        let Node { value, next } = *self.head.take()?;
        self.head = next;
        Some(value)
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|head| &head.value)
    }

    #[must_use]
    pub fn rev(mut self) -> SimpleLinkedList<T> {
        let mut new_list = Self::new();
        while !self.is_empty() {
            new_list.push(self.pop().unwrap());
        }
        new_list
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut new_list = Self::new();
        for value in iter {
            new_list.push(value);
        }
        new_list
    }
}

// In general, it would be preferable to implement IntoIterator for SimpleLinkedList<T>
// instead of implementing an explicit conversion to a vector. This is because, together,
// FromIterator and IntoIterator enable conversion between arbitrary collections.
//
// The reason this exercise's API includes an explicit conversion to Vec<T> instead
// of IntoIterator is that implementing that interface is fairly complicated, and
// demands more of the student than we expect at this point in the track.
//
// Please note that the "front" of the linked list should correspond to the "back"
// of the vector as far as the tests are concerned.

impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut new_list = Vec::new();
        while !linked_list.is_empty() {
            new_list.push(linked_list.pop().unwrap());
        }
        new_list.reverse();
        new_list
    }
}
