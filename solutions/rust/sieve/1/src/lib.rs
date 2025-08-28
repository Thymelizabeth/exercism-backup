pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let mut primes = (2..=upper_bound)
        .zip(std::iter::repeat(false))
        .collect::<Vec<_>>();

    for i in 0..primes.len() {
        let (p, is_marked) = primes[i];
        if !is_marked {
            let multiples = (p..=upper_bound).step_by(p as usize).collect::<Vec<_>>();
            for n in primes[i + 1..].iter_mut() {
                if multiples.contains(&n.0) {
                    (*n).1 = true;
                }
            }
        }
    }

    primes
        .into_iter()
        .filter_map(|(p, is_marked)| if !is_marked { Some(p) } else { None })
        .collect()
}
