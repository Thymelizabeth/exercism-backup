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
        Ok(input
            .windows(span)
            .map(|w| w.into_iter().product::<u64>())
            .reduce(|a, b| a.max(b))
            .unwrap())
    }
}
