use std::num::NonZero;

pub fn collatz(n: u64) -> Option<u64> {
    NonZero::new(n).map(|n| collatz_acc(n, 0))
}

fn collatz_acc(n: NonZero<u64>, c: u64) -> u64 {
    if n.get() == 1 {
        c
    } else if n.get() % 2 == 0 {
        collatz_acc(NonZero::new(n.get() / 2).unwrap(), c + 1)
    } else {
        collatz_acc(n.checked_mul(NonZero::new(3).unwrap()).and_then(|n| n.checked_add(1)).unwrap(), c + 1)
    }
}
