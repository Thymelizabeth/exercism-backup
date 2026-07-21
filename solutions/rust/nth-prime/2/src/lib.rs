pub fn nth(n: u32) -> u32 {
    let mut primes = Vec::new();
    (2..)
        .filter(|&i| {
            for p in &primes {
                if i % p == 0 {
		    return false;
		}
            }
            primes.push(i);
            true
        })
        .nth(n as usize)
        .expect("Primes are infinite")
}
