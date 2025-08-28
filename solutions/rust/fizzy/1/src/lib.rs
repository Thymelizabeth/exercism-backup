// the PhantomData instances in this file are just to stop compiler complaints
// about missing generics; feel free to remove them

use std::ops::Rem;

/// A Matcher is a single rule of fizzbuzz: given a function on T, should
/// a word be substituted in? If yes, which word?
pub struct Matcher<T> {
    matcher: Box<dyn Fn(T) -> bool>,
    substitution: String,
}

impl<T> Matcher<T> {
    pub fn new(matcher: impl Fn(T) -> bool + 'static, substitution: impl ToString) -> Matcher<T> {
        Self {
            matcher: Box::from(matcher),
            substitution: substitution.to_string(),
        }
    }
}

/// A Fizzy is a set of matchers, which may be applied to an iterator.
///
/// Strictly speaking, it's usually more idiomatic to use `iter.map()` than to
/// consume an iterator with an `apply` method. Given a Fizzy instance, it's
/// pretty straightforward to construct a closure which applies it to all
/// elements of the iterator. However, we're using the `apply` pattern
/// here because it's a simpler interface for students to implement.
///
/// Also, it's a good excuse to try out using impl trait.
pub struct Fizzy<T>(Vec<Matcher<T>>);

impl<T> Fizzy<T> {
    pub fn new() -> Self {
        Self(Vec::new())
    }

    // feel free to change the signature to `mut self` if you like
    #[must_use]
    pub fn add_matcher(mut self, matcher: Matcher<T>) -> Self {
        self.0.push(matcher);
        self
    }
}
impl<T: ToString + Clone> Fizzy<T> {
    /// map this fizzy onto every element of an iterator, returning a new iterator
    pub fn apply<I: Iterator<Item = T>>(self, iter: I) -> impl Iterator<Item = String> {
        // todo!() doesn't actually work, here; () is not an Iterator
        // that said, this is probably not the actual implementation you desire
        iter.map(move |n| {
            let sub = self
                .0
                .iter()
                .filter_map(|m| {
                    if (m.matcher)(n.clone().into()) {
                        Some(m.substitution.clone())
                    } else {
                        None
                    }
                })
                .collect::<String>();
            if sub.is_empty() {
                n.to_string()
            } else {
                sub
            }
        })
    }
}

/// convenience function: return a Fizzy which applies the standard fizz-buzz rules
pub fn fizz_buzz<T: Rem + From<u8>>() -> Fizzy<T>
where
    <T as Rem>::Output: PartialEq + From<u8>,
{
    Fizzy::new()
        .add_matcher(Matcher::new(|n| n % 3.into() == 0.into(), "fizz"))
        .add_matcher(Matcher::new(|n| n % 5.into() == 0.into(), "buzz"))
}
