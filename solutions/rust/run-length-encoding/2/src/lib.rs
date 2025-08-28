pub fn encode(source: &str) -> String {
    let (acc, n, c) = source
        .chars()
        .fold((String::new(), 0, ' '), |(acc, n, last_c), c| {
            if last_c == c {
                (acc, n + 1, c)
            } else if n == 0 {
                (acc, 1, c)
            } else if n == 1 {
                (acc + &last_c.to_string(), 1, c)
            } else {
                (acc + &format!("{}", n) + &last_c.to_string(), 1, c)
            }
        });
    if n == 0 {
        acc
    } else if n == 1 {
        acc + &c.to_string()
    } else {
        acc + &format!("{}", n) + &c.to_string()
    }
}

pub fn decode(source: &str) -> String {
    source
        .chars()
        .fold((String::new(), 0), |(mut acc, n), c| {
            if c.is_ascii_digit() {
                if n == 0 {
                    (acc, c.to_digit(10).unwrap() as usize)
                } else {
                    (acc, 10 * n + c.to_digit(10).unwrap() as usize)
                }
            } else {
                if n == 0 {
                    acc.push(c);
                } else {
                    acc.push_str(&c.to_string().repeat(n));
                }
                (acc, 0)
            }
        })
        .0
}
