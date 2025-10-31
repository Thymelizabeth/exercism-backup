pub fn annotate(garden: &[&str]) -> Vec<String> {
    (0..garden.len())
        .map(|i| {
            (0..garden[i].len())
                .map(|j| {
                    if garden[i].as_bytes()[j] == b'*' {
                        "*".to_string()
                    } else {
                        let n = [
                            (i.wrapping_sub(1), j.wrapping_sub(1)),
                            (i.wrapping_sub(1), j),
                            (i.wrapping_sub(1), j + 1),
                            (i, j.wrapping_sub(1)),
                            (i, j + 1),
                            (i + 1, j.wrapping_sub(1)),
                            (i + 1, j),
                            (i + 1, j + 1),
                        ]
                        .iter()
                        .fold(0, |acc, (row, col)| {
                            acc + garden.get(*row).is_some_and(|r| {
                                r.as_bytes().get(*col).is_some_and(|square| *square == b'*')
                            }) as u32
                        });
                        if n == 0 {
                            " ".to_string()
                        } else {
                            format!("{}", n)
                        }
                    }
                })
                .collect()
        })
        .collect()
}
