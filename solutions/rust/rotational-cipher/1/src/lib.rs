pub fn rotate(input: &str, key: u8) -> String {
    input
        .chars()
        .filter_map(|c| {
            if c.is_ascii_uppercase() {
                char::from_u32((c as u32 - 'A' as u32 + (key as u32 % 26)) % 26 + 'A' as u32)
            } else if c.is_ascii_lowercase() {
                char::from_u32((c as u32 - 'a' as u32 + (key as u32 % 26)) % 26 + 'a' as u32)
            } else {
                Some(c)
            }
        })
        .collect()
}
