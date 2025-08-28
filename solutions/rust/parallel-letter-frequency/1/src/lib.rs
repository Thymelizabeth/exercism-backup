use rayon::prelude::*;
use std::collections::HashMap;

pub fn frequency(input: &[&str], _worker_count: usize) -> HashMap<char, usize> {
    input
        .par_iter()
        .map(|s| {
            s.chars()
                .filter(|c| c.is_alphabetic())
                .fold(HashMap::new(), |mut acc, c| {
                    *acc.entry(c.to_ascii_lowercase()).or_insert(0) += 1;
                    acc
                })
        })
        .reduce(HashMap::new, |acc, char_counts| {
            let acc = std::sync::Mutex::new(acc);
            char_counts
                .into_par_iter()
                .for_each(|(c, count)| *acc.lock().unwrap().entry(c).or_insert(0) += count);
            acc.into_inner().unwrap()
        })
}
