use std::num::NonZero;

const TWO: NonZero<u64> = NonZero::new(2).expect("Two is non-zero");
const THREE: NonZero<u64> = NonZero::new(3).expect("Three is non-zero");

pub fn collatz(n: u64) -> Option<u64> {
    NonZero::new(n).map(|n| collatz_acc(n, 0))
}

fn collatz_acc(n: NonZero<u64>, c: u64) -> u64 {
    if n.get() == 1 {
        c
    } else if n.get() % 2 == 0 {
        collatz_acc(n.div_ceil(TWO), c + 1)
    } else {
        collatz_acc(n.checked_mul(THREE).and_then(|n| n.checked_add(1)).expect("u64 should be big enough"), c + 1)
    }
}
