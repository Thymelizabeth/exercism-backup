use std::io::{Read, Result, Write};

// the PhantomData instances in this file are just to stop compiler complaints
// about missing generics; feel free to remove them

pub struct ReadStats<R> {
    reader: R,
    bytes_through: usize,
    reads: usize
}
impl<R: Read> ReadStats<R> {
    pub fn new(reader: R) -> ReadStats<R> {
        Self {
            reader,
            bytes_through: 0,
            reads: 0
        }
    }

    pub fn get_ref(&self) -> &R {
        &self.reader
    }

    pub fn bytes_through(&self) -> usize {
        self.bytes_through
    }

    pub fn reads(&self) -> usize {
        self.reads
    }
}

impl<R: Read> Read for ReadStats<R> {
    fn read(&mut self, buf: &mut [u8]) -> Result<usize> {
        self.reads += 1;
        self.reader.read(buf).inspect(|bytes_read| self.bytes_through +=bytes_read)
    }
}

pub struct WriteStats<W> {
    writer: W,
    bytes_through: usize,
    writes: usize
}

impl<W: Write> WriteStats<W> {
    pub fn new(writer: W) -> WriteStats<W> {
        Self {
            writer,
            bytes_through: 0,
            writes: 0
        }
    }

    pub fn get_ref(&self) -> &W {
        &self.writer
    }

    pub fn bytes_through(&self) -> usize {
        self.bytes_through
    }

    pub fn writes(&self) -> usize {
        self.writes
    }
}

impl<W: Write> Write for WriteStats<W> {
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        self.writes += 1;
        self.writer.write(buf).inspect(|bytes_written| self.bytes_through += bytes_written)
    }

    fn flush(&mut self) -> Result<()> {
        self.writer.flush()
    }
}
