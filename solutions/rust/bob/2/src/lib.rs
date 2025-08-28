pub fn reply(message: &str) -> &str {
    match message {
        m if m.trim().is_empty() => "Fine. Be that way!",
        m if m.trim().ends_with('?')
            && m.chars().all(|c| !c.is_alphabetic() || c.is_uppercase())
            && m.chars().any(|c| c.is_alphabetic()) =>
        {
            "Calm down, I know what I'm doing!"
        }
        m if m.trim().ends_with('?') => "Sure.",
        m if m.chars().all(|c| !c.is_alphabetic() || c.is_uppercase())
            && m.chars().any(|c| c.is_alphabetic()) =>
        {
            "Whoa, chill out!"
        }
        _ => "Whatever.",
    }
}
