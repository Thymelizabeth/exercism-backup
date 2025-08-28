pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let mut numbers = (0..=upper_bound).map(Option::from).collect::<Vec<_>>();
    (2..numbers.len())
        .filter_map(|i| {
            let prime = numbers[i].take()? as usize;
            (prime * prime..=upper_bound as usize)
                .step_by(prime)
                .for_each(|j| numbers[j] = None);
            Some(prime as u64)
        })
        .collect()
}
