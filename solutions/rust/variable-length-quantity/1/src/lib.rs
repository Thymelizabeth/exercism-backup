#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    IncompleteNumber,
}

/// Convert a list of numbers to a stream of bytes encoded with variable length encoding.
pub fn to_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().copied().flat_map(to_vlq).collect()
}

/// Given a stream of bytes, extract all numbers which are encoded in there.
pub fn from_bytes(bytes: &[u8]) -> Result<Vec<u32>, Error> {
    bytes
        .split_inclusive(|item| item & 128 == 0)
        .map(|seq| match seq {
            [num] if num & 128 == 0 => Ok(*num as u32),
            [num1, num2] if num2 & 128 == 0 => {
                let left = ((num1 & 0x7F) as u32) << 7;
                Ok(left | *num2 as u32)
            }
            [num1, num2, num3] if num3 & 128 == 0 => {
                let left = ((num1 & 0x7F) as u32) << 14;
                let mid = ((num2 & 0x7F) as u32) << 7;
                Ok(left | mid | *num3 as u32)
            }
            [num1, num2, num3, num4] if num4 & 128 == 0 => {
                let left = ((num1 & 0x7F) as u32) << 21;
                let midleft = ((num2 & 0x7F) as u32) << 14;
                let midright = ((num3 & 0x7F) as u32) << 7;
                Ok(left | midleft | midright | *num4 as u32)
            }
            [num1, num2, num3, num4, num5] if num5 & 0x80 == 0 => {
                let farleft = ((num1 & 0x7F) as u32) << 28;
                let left = ((num2 & 0x7F) as u32) << 21;
                let midleft = ((num3 & 0x7F) as u32) << 14;
                let midright = ((num4 & 0x7F) as u32) << 7;
                Ok(farleft | left | midleft | midright | *num5 as u32)
            }
            _ => Err(Error::IncompleteNumber),
        })
        .collect()
}

fn to_vlq(value: u32) -> Vec<u8> {
    match value {
        0..=0x7F => vec![value as u8],
        128..=0x3FFF => vec![((value >> 7) | 0x80) as u8, (value & 0x7f) as u8],
        16384..=0x1FFFFF => vec![
            ((value >> 14) | 0x80) as u8,
            ((value >> 7) | 0x80) as u8,
            (value & 0x7F) as u8,
        ],
        2097152..=0x0FFFFFFF => vec![
            ((value >> 21) | 0x80) as u8,
            ((value >> 14) | 0x80) as u8,
            ((value >> 7) | 0x80) as u8,
            (value & 0x7F) as u8,
        ],
        268435456..=u32::MAX => vec![
            ((value >> 28) | 0x80) as u8,
            ((value >> 21) | 0x80) as u8,
            ((value >> 14) | 0x80) as u8,
            ((value >> 7) | 0x80) as u8,
            (value & 0x7F) as u8,
        ],
    }
}
