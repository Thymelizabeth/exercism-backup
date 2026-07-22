pub struct RailFence(u32);

impl RailFence {
    pub fn new(rails: u32) -> RailFence {
        RailFence(rails)
    }

    pub fn encode(&self, text: &str) -> String {
        let mut rails = vec![String::new(); self.0 as usize];
        let r_seq = (0..self.0 as usize)
            .chain((1..self.0 as usize - 1).rev())
            .cycle();
        for (c, i) in text.chars().zip(r_seq) {
            rails[i].push(c);
        }
        rails.join("")
    }

    pub fn decode(&self, cipher: &str) -> String {
        let mut rails = vec![String::new(); self.0 as usize];
        let r_seq = (0..self.0 as usize)
            .chain((1..self.0 as usize - 1).rev())
            .cycle();
        let mut n = 0;
        for (i, rail) in rails.iter_mut().enumerate() {
            let rail_count = r_seq
                .clone()
                .zip(cipher.chars())
                .filter(|(r, _)| *r == i)
                .count();
            *rail = cipher.chars().skip(n).take(rail_count).collect();
            n += rail_count;
        }
        let mut result = String::new();
        let mut progress = vec![0; self.0 as usize];
        for r in r_seq {
            match rails.get(r).and_then(|s| {
                let c = s.chars().nth(progress[r])?;
                progress[r] += 1;
                Some(c)
            }) {
                None => break,
                Some(c) => result.push(c),
            }
        }
        result
    }
}
