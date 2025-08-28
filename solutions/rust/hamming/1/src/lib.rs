use std::iter::zip;

/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.len() != s2.len() {
        None
    } else {
        Some(
            zip(s1.chars(), s2.chars()).fold(0, |acc, (c1, c2)| acc + (if c1 != c2 { 1 } else { 0 }))
        )
    }
}
