pub struct Luhn {
    num: String,
}

impl Luhn {
    pub fn is_valid(&self) -> bool {
        if !self.num.chars().all(|c| c == ' ' || c.is_ascii_digit())
            || self.num.chars().filter(|c| *c != ' ').count() <= 1
        {
            false
        } else {
            self.num
                .chars()
                .filter(|c| c.is_ascii_digit())
                .rev()
                .enumerate()
                .map(|(i, c)| {
                    if i % 2 == 0 {
                        c.to_digit(10).unwrap()
                    } else {
                        let x = c.to_digit(10).unwrap() * 2;
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

/// Here is the example of how the From trait could be implemented
/// for the &str type. Naturally, you can implement this trait
/// by hand for every other type presented in the test suite,
/// but your solution will fail if a new type is presented.
/// Perhaps there exists a better solution for this problem?
impl<T: ToString> From<T> for Luhn {
    fn from(input: T) -> Self {
        Self {
            num: input.to_string(),
        }
    }
}
