use core::default::Default;
#[derive(Debug)]
pub struct CircularBuffer<T> {
    data: Box<[T]>,
    read: usize,
    write: usize,
}

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T: Default + Clone> CircularBuffer<T> {
    pub fn new(capacity: usize) -> Self {
        CircularBuffer {
            data: vec![T::default(); capacity + 1].into_boxed_slice(),
            read: 0,
            write: 0,
        }
    }

    pub fn write(&mut self, element: T) -> Result<(), Error> {
        let pos = (self.write + 1) % self.data.len();
        if pos == self.read {
            // the buffer can hold no more new data
            Err(Error::FullBuffer)
        } else {
            self.data[self.write] = element;
            self.write = pos;
            Ok(())
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        if self.read == self.write {
            Err(Error::EmptyBuffer)
        } else {
            let element = self.data[self.read].clone();
            self.read = (self.read + 1) % self.data.len();
            Ok(element)
        }
    }

    pub fn clear(&mut self) {
        self.read = 0;
        self.write = 0;
        self.data.fill(Default::default());
    }

    pub fn overwrite(&mut self, element: T) {
        let pos = (self.write + 1) % self.data.len();
        if pos == self.read {
            self.data[self.write] = element;
            self.write = self.read;
            self.read = (self.read + 1) % self.data.len();
        } else {
            self.write(element).unwrap();
        }
    }
}
