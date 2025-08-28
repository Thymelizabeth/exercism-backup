pub fn is_armstrong_number(num: u32) -> bool {
    let digits = digits(num);
    num == digits.iter().map(|d| d.pow(digits.len() as u32)).sum()
}

fn digits(num: u32) -> Vec<u32> {
    let mut num = num;
    let mut result = vec![];
    loop {
        if num < 10 {
            result.push(num);
            break;
        } else {
            result.push(num % 10);
            num /= 10;
        }
    }
    result
}
