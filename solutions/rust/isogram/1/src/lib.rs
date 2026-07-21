pub fn check(candidate: &str) -> bool {
    candidate
        .chars()
        .try_fold(
            std::collections::HashSet::new(),
            |mut letters, next| match next {
                '-' | ' ' => Some(letters),
                c => letters.insert(c.to_ascii_lowercase()).then_some(letters),
            },
        )
        .is_some()
}
