use std::collections::HashMap;

/// Count occurrences of words.
pub fn word_count(words: &str) -> HashMap<String, u32> {
    words.to_ascii_lowercase().split(|c: char| !(c.is_ascii_alphanumeric() || c == '\'')).map(|word| word.trim_matches('\'')).filter(|word| !word.is_empty()).fold(HashMap::new(), |mut freq_map, word| {
        *freq_map.entry(word.to_string()).or_insert(0) += 1;
        freq_map
    })
}
