pub fn series(digits: &str, len: usize) -> Vec<String> {
    digits.chars().collect::<Vec<_>>().as_slice().windows(len).map(|window| window.into_iter().collect::<String>()).collect()
}
