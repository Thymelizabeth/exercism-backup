pub fn encrypt(input: &str) -> String {
    let input = input
        .chars()
        .filter(char::is_ascii_alphanumeric)
        .map(|c| c.to_ascii_lowercase())
        .collect::<String>();
    let (r, c) = 'outer: {
        for c in 0..=input.chars().count() {
            for r in c.saturating_sub(1)..=c {
                if r * c >= input.chars().count() {
                    break 'outer (r, c);
                }
            }
        }
        (0, 0)
    };
    let mut rows = vec![vec![' '; c]; r];
    let mut input = input.chars();
    for row in &mut rows {
        for col in row {
            *col = input.next().unwrap_or(' ');
        }
    }
    let mut output = String::new();
    for i in 0..c {
        for row in &mut rows {
            let next = row[i];
            output.push(next);
        }
        if i != c - 1 {
            output.push(' ');
        }
    }
    output
}
