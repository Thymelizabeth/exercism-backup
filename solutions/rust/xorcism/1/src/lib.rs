use std::borrow::Borrow;

/// A munger which XORs a key with some data
pub struct Xorcism<'a, Key: AsRef<[u8]> + ?Sized> {
    key: &'a Key,
    pos: usize,
}

impl<Key: AsRef<[u8]> + ?Sized> Clone for Xorcism<'_, Key> {
    fn clone(&self) -> Self {
        Xorcism {
            key: self.key,
            pos: self.pos,
        }
    }
}

impl<'a, Key: AsRef<[u8]> + ?Sized> Xorcism<'a, Key> {
    /// Create a new Xorcism munger from a key
    ///
    /// Should accept anything which has a cheap conversion to a byte slice.
    pub fn new(key: &'a Key) -> Xorcism<'a, Key> {
        Xorcism { key, pos: 0 }
    }

    /// XOR each byte of the input buffer with a byte from the key.
    ///
    /// Note that this is stateful: repeated calls are likely to produce different results,
    /// even with identical inputs.
    pub fn munge_in_place(&mut self, data: &mut [u8]) {
        for byte in data.iter_mut() {
            *byte ^= self.key.as_ref()[self.pos];
            self.pos = (self.pos + 1) % self.key.as_ref().len();
        }
    }

    /// XOR each byte of the data with a byte from the key.
    ///
    /// Note that this is stateful: repeated calls are likely to produce different results,
    /// even with identical inputs.
    ///
    /// Should accept anything which has a cheap conversion to a byte iterator.
    /// Shouldn't matter whether the byte iterator's values are owned or borrowed.
    pub fn munge<Data: IntoIterator<Item = impl Borrow<u8>>>(
        &mut self,
        data: Data,
    ) -> impl Iterator<Item = u8> {
        data.into_iter().map(|item| {
            let result = self.key.as_ref()[self.pos] ^ item.borrow();
            self.pos = (self.pos + 1) % self.key.as_ref().len();
            result
        })
    }
}
