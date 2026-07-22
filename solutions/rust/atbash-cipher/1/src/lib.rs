static KEY: std::sync::LazyLock<std::collections::HashMap<char, char>> =
    std::sync::LazyLock::new(|| {
        "abcdefghijklmnopqrstuvwxyz"
            .chars()
            .zip("zyxwvutsrqponmlkjihgfedcba".chars())
            .collect()
    });

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    plain
        .chars()
        .filter_map(|c| {
            if c.is_ascii_alphabetic() {
                KEY.get(&c.to_ascii_lowercase()).copied()
            } else if c.is_numeric() {
                Some(c)
            } else {
                None
            }
        })
        .fold(String::new(), |mut cyphertext, c| {
            if cyphertext
                .rsplit_once(' ')
                .is_some_and(|(_, end)| end.len() == 5)
                || cyphertext.len() == 5
            {
                cyphertext.push(' ');
            }
            cyphertext.push(c);
            cyphertext
        })
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher
        .chars()
        .map(|c| KEY.get(&c).copied().unwrap_or(c))
        .filter(|c| *c != ' ')
        .collect()
}
