/// Yields each item of a and then each item of b
pub fn append<I: Iterator, J>(a: I, b: J) -> impl Iterator<Item = I::Item>
where
    J: Iterator<Item = I::Item>,
{
    struct Append<I, J>(I, J);

    impl<I, J> Iterator for Append<I, J>
    where
        I: Iterator,
        J: Iterator<Item = I::Item>,
    {
        type Item = I::Item;

        fn next(&mut self) -> Option<Self::Item> {
            match self.0.next() {
                None => self.1.next(),
                Some(item) => Some(item),
            }
        }
    }

    Append(a, b)
}

/// Combines all items in all nested iterators inside into one flattened iterator
pub fn concat<I: Iterator>(nested_iterator: I) -> impl Iterator<Item = <I::Item as Iterator>::Item>
where
    I::Item: Iterator,
{
    struct Concat<I: Iterator>(Option<I::Item>, I);

    impl<I> Iterator for Concat<I>
    where
        I: Iterator,
        I::Item: Iterator,
    {
        type Item = <I::Item as Iterator>::Item;

        fn next(&mut self) -> Option<Self::Item> {
            loop {
                if self.0.is_none() {
                    self.0 = Some(self.1.next()?);
                }
                if let Some(item) = self.0.as_mut()?.next() {
                    break Some(item);
                }
                self.0 = None;
            }
        }
    }

    Concat(None, nested_iterator)
}

/// Returns an iterator of all items in iter for which `predicate(item)` is true
pub fn filter<I: Iterator, F>(iter: I, predicate: F) -> impl Iterator<Item = I::Item>
where
    F: Fn(&I::Item) -> bool,
{
    struct Filter<I, F>(I, F);
    impl<I: Iterator, F: Fn(&I::Item) -> bool> Iterator for Filter<I, F> {
        type Item = I::Item;

        fn next(&mut self) -> Option<Self::Item> {
            loop {
                match self.0.next() {
                    Some(item) if self.1(&item) => break Some(item),
                    None => break None,
                    Some(_) => continue,
                }
            }
        }
    }
    Filter(iter, predicate)
}

pub fn length<I: Iterator>(iter: I) -> usize {
    let mut len = 0;
    for _ in iter {
        len += 1;
    }
    len
}

/// Returns an iterator of the results of applying `function(item)` on all iter items
pub fn map<I: Iterator, F, U>(iter: I, function: F) -> impl Iterator<Item = U>
where
    F: Fn(I::Item) -> U,
{
    struct Map<I: Iterator, U, F: Fn(I::Item) -> U>(I, F);
    impl<I, U, F> Iterator for Map<I, U, F>
    where
        I: Iterator,
        F: Fn(I::Item) -> U,
    {
        type Item = U;

        fn next(&mut self) -> Option<Self::Item> {
            match self.0.next() {
                Some(item) => Some(self.1(item)),
                None => None,
            }
        }
    }
    Map(iter, function)
}

pub fn foldl<I: Iterator, F, U>(iter: I, initial: U, function: F) -> U
where
    F: Fn(U, I::Item) -> U,
{
    let mut result = initial;
    for item in iter {
        result = function(result, item);
    }
    result
}

pub fn foldr<I: DoubleEndedIterator, F, U>(mut iter: I, initial: U, function: F) -> U
where
    F: Fn(U, I::Item) -> U,
{
    let mut result = initial;
    while let Some(item) = iter.next_back() {
        result = function(result, item);
    }
    result
}

/// Returns an iterator with all the original items, but in reverse order
pub fn reverse<I: DoubleEndedIterator>(iter: I) -> impl Iterator<Item = I::Item> {
    struct Reverse<I>(I);
    impl<I: DoubleEndedIterator> Iterator for Reverse<I> {
        type Item = I::Item;

        fn next(&mut self) -> Option<Self::Item> {
            self.0.next_back()
        }
    }
    Reverse(iter)
}
