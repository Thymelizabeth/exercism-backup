#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit(char),
}

pub fn lsp(string_digits: &str, span: usize) -> Result<u64, Error> {
    if span > string_digits.len() {
        Err(Error::SpanTooLong)
    } else {
        let input = string_digits
            .chars()
            .map(|c| c.to_digit(10).ok_or(Error::InvalidDigit(c)))
            .collect::<Result<Vec<_>, Error>>()?
            .into_iter()
            .map(|n| n as u64)
            .collect::<Vec<u64>>();
        Ok(std::num::NonZero::new(span).and_then(|span| input
            .windows(span.get())
            .map(|w| w.iter().product::<u64>())
            .max()).unwrap_or(1))
    }
}
