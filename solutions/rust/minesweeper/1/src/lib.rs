pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield
        .iter()
        .enumerate()
        .map(|(x, row)| {
            row.chars()
                .enumerate()
                .map(|(y, square)| {
                    if square == '*' {
                        square
                    } else {
                        let res = find_mines(x, y, &minefield);
                        if res > 0 {
                            char::from_digit(res, 10).unwrap()
                        } else {
                            ' '
                        }
                    }
                })
                .collect::<String>()
        })
        .collect::<Vec<_>>()
}

fn find_mines(x: usize, y: usize, minefield: &[&str]) -> u32 {
    [
        (x.checked_sub(1), y.checked_sub(1)),
        (x.checked_sub(1), Some(y)),
        (x.checked_sub(1), Some(y + 1)),
        (Some(x), y.checked_sub(1)),
        (Some(x), Some(y + 1)),
        (Some(x + 1), y.checked_sub(1)),
        (Some(x + 1), Some(y)),
        (Some(x + 1), Some(y + 1)),
    ]
    .into_iter()
    .filter_map(|(x, y)| Some((x?, y?)))
    .filter_map(|(x, y)| minefield.get(x).and_then(|row| row.chars().nth(y)))
    .filter(|square| *square == '*')
    .count() as u32
}
