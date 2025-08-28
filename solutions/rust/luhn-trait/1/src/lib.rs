pub trait Luhn {
    fn valid_luhn(&self) -> bool;
}

/// Here is the example of how to implement custom Luhn trait
/// for the &str type. Naturally, you can implement this trait
/// by hand for every other type presented in the test suite,
/// but your solution will fail if a new type is presented.
/// Perhaps there exists a better solution for this problem?
impl<T: ToString> Luhn for T {
    fn valid_luhn(&self) -> bool {
        let code = self.to_string();
        if !code.chars().all(|c| c == ' ' || c.is_ascii_digit())
            || code.chars().filter(|c| *c != ' ').count() <= 1
        {
            false
        } else {
            code.chars()
                .filter(|c| c.is_ascii_digit())
                .rev()
                .enumerate()
                .map(|(idx, c)| {
                    let x = c.to_digit(10).unwrap();
                    if idx % 2 == 0 {
                        x
                    } else {
                        let x = x * 2;
                        if x > 9 {
                            x - 9
                        } else {
                            x
                        }
                    }
                })
                .sum::<u32>()
                % 10
                == 0
        }
    }
}
