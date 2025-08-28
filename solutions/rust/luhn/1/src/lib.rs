/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    if !code.chars().all(|c| c == ' ' || c.is_digit(10)) ||
        code.chars().filter(|&c| c != ' ').count() <= 1 {
        false
    } else {
        code.chars().filter(|&c| c.is_digit(10)).rev().enumerate().map(|(idx, c)| {
            let x: u32 = c.to_string().parse().unwrap();
            if idx % 2 == 0 {
                x
            } else {
                let x2 = x * 2;
                if x2 > 9 {
                    x2 - 9
                } else {
                    x2
                }
            }
        }).sum::<u32>() % 10 == 0
    }
}
