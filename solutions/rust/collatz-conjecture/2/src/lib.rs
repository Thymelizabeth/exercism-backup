pub fn collatz(n: u64) -> Option<u64> {
    match n {
        0 => None,
        1 => Some(0),
        n => Some(collatz_acc(n, 0)),
    }
}

fn collatz_acc(n: u64, c: u64) -> u64 {
    if n == 1 {
        c
    } else if n % 2 == 0 {
        collatz_acc(n / 2, c + 1)
    } else {
        collatz_acc(n * 3 + 1, c + 1)
    }
}
