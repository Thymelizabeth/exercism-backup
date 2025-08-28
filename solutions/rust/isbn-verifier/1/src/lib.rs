/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    if !isbn
        .chars()
        .all(|c| c.is_ascii_digit() || c == 'X' || c == '-')
    {
        return false;
    }
    let isbn = isbn
        .chars()
        .filter(|c| c.is_ascii_digit() || *c == 'X')
        .collect::<Vec<char>>();

    isbn.len() == 10
        && !isbn[..9].iter().any(|c| *c == 'X')
        && isbn
            .into_iter()
            .enumerate()
            .filter_map(|(i, c)| {
                Some(
                    match c {
                        '0'..='9' => c.to_digit(10)?,
                        'X' if i == 9 => 10,
                        _ => None?,
                    } as usize
                        * (10 - i),
                )
            })
            .sum::<usize>()
            % 11
            == 0
}
