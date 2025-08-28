use std::cmp::Ordering;

#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    if num == 0 {
        None
    } else {
        Some(match aliquot_sum(num).cmp(&num) {
            Ordering::Greater => Classification::Abundant,
            Ordering::Equal => Classification::Perfect,
            Ordering::Less => Classification::Deficient,
        })
    }
}

fn aliquot_sum(num: u64) -> u64 {
    (1..num).filter(|n| num % n == 0).sum()
}
