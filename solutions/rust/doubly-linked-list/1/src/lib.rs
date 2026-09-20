use core::ptr::NonNull;

// this module adds some functionality based on the required implementations
// here like: `LinkedList::pop_back` or `Clone for LinkedList<T>`
// You are free to use anything in it, but it's mainly for the test framework.
mod pre_implemented;

struct Node<T> {
    data: T,
    next: Option<NonNull<Node<T>>>,
    prev: Option<NonNull<Node<T>>>,
}

pub struct LinkedList<T> {
    first: Option<NonNull<Node<T>>>,
    last: Option<NonNull<Node<T>>>,
    len: usize,
}

pub struct Cursor<'a, T> {
    cur: Option<NonNull<Node<T>>>,
    list: &'a mut LinkedList<T>,
}

pub struct Iter<'a, T> {
    cur: Option<NonNull<Node<T>>>,
    _list: &'a LinkedList<T>,
}

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        Self {
            first: None,
            last: None,
            len: 0,
        }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for LinkedList)
    pub fn is_empty(&self) -> bool {
        self.first.is_none()
    }

    pub fn len(&self) -> usize {
        self.len
    }

    /// Return a cursor positioned on the front element
    pub fn cursor_front(&mut self) -> Cursor<'_, T> {
        Cursor {
            cur: self.first,
            list: self,
        }
    }

    /// Return a cursor positioned on the back element
    pub fn cursor_back(&mut self) -> Cursor<'_, T> {
        Cursor {
            cur: self.last,
            list: self,
        }
    }

    /// Return an iterator that moves from front to back
    pub fn iter(&self) -> Iter<'_, T> {
        Iter {
            cur: self.first,
            _list: self,
        }
    }
}

impl<T> Drop for LinkedList<T> {
    fn drop(&mut self) {
        let mut cursor = self.cursor_front();
        while cursor.take().is_some() {}
    }
}

// the cursor is expected to act as if it is at the position of an element
// and it also has to work with and be able to insert into an empty list.
impl<T> Cursor<'_, T> {
    /// Take a mutable reference to the current element
    pub fn peek_mut(&mut self) -> Option<&mut T> {
        unsafe { Some(&mut self.cur?.as_mut().data) }
    }

    /// Move one position forward (towards the back) and
    /// return a reference to the new position
    #[allow(clippy::should_implement_trait)]
    pub fn next(&mut self) -> Option<&mut T> {
        unsafe {
            self.cur = self.cur?.as_ref().next;
            Some(&mut self.cur?.as_mut().data)
        }
    }

    /// Move one position backward (towards the front) and
    /// return a reference to the new position
    pub fn prev(&mut self) -> Option<&mut T> {
        unsafe {
            self.cur = self.cur?.as_ref().prev;
            Some(&mut self.cur?.as_mut().data)
        }
    }

    /// Remove and return the element at the current position and move the cursor
    /// to the neighboring element that's closest to the back. This can be
    /// either the next or previous position.
    pub fn take(&mut self) -> Option<T> {
        unsafe {
            let mut old_cur = self.cur?;
            self.cur = if old_cur.as_ref().next.is_some() {
                old_cur.as_ref().next
            } else {
                old_cur.as_ref().prev
            };
            match old_cur.as_mut().prev {
                Some(mut prev) => prev.as_mut().next = old_cur.as_ref().next,
                None => self.list.first = old_cur.as_ref().next,
            }
            match old_cur.as_mut().next {
                Some(mut next) => next.as_mut().prev = old_cur.as_ref().prev,
                None => self.list.last = old_cur.as_ref().prev,
            }
            self.list.len -= 1;
            Some(Box::from_raw(old_cur.as_ptr()).data)
        }
    }

    pub fn insert_after(&mut self, element: T) {
        let mut node = Node {
            data: element,
            next: None,
            prev: None,
        };
        match self.cur {
            None => {
                self.list.first = NonNull::new(Box::into_raw(Box::new(node)));
                self.list.last = self.list.first;
            }
            Some(mut cur) => unsafe {
                node.prev = Some(cur);
                node.next = cur.as_ref().next;
                let mut node = NonNull::new(Box::into_raw(Box::new(node)))
                    .expect("NonNull from Box should always be Some");
                if self.list.last == Some(cur) {
                    self.list.last = Some(node);
                }
                if let Some(mut next) = node.as_mut().next {
                    next.as_mut().prev = Some(node);
                }
                cur.as_mut().next = Some(node);
            },
        }
        self.list.len += 1;
    }

    pub fn insert_before(&mut self, element: T) {
        let mut node = Node {
            data: element,
            next: None,
            prev: None,
        };
        match self.cur {
            None => {
                self.list.last = NonNull::new(Box::into_raw(Box::new(node)));
                self.list.first = self.list.last;
            }
            Some(mut cur) => unsafe {
                node.next = Some(cur);
                node.prev = cur.as_ref().prev;
                let mut node = NonNull::new(Box::into_raw(Box::new(node)))
                    .expect("NonNull from Box should always be Some");
                if self.list.first == Some(cur) {
                    self.list.first = Some(node);
                }
                if let Some(mut prev) = node.as_mut().prev {
                    prev.as_mut().next = Some(node);
                }
                cur.as_mut().prev = Some(node);
            },
        }
        self.list.len += 1;
    }
}

impl<'a, T> Iterator for Iter<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<&'a T> {
        let cur = unsafe { self.cur?.as_ref() };
        let cur_data = &cur.data;
        self.cur = cur.next;
        Some(cur_data)
    }
}
