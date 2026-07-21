pub fn nth(n: u32) -> u32 {
    let mut primes = Vec::new();
    (2..)
        .filter(|&i| {
            for p in &primes {
                let mut c = 1;
                loop {
                    if c * p > i {
                        break;
                    } else if c * p == i {
                        return false;
                    } else {
                        c += 1;
                    }
                }
            }
            primes.push(i);
            true
        })
        .nth(n as usize)
        .expect("Primes are infinite")
}
