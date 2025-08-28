use rand::prelude::*;
use std::collections::HashSet;
use std::sync::{LazyLock, Mutex};

pub struct Robot(String);
static NAMES_USED: LazyLock<Mutex<HashSet<String>>> = LazyLock::new(|| Mutex::new(HashSet::new()));

impl Robot {
    pub fn new() -> Self {
        let mut rng = StdRng::seed_from_u64(NAMES_USED.lock().unwrap().len() as u64);
        loop {
            let new_name1 = ('A'..='Z').chain('A'..='Z').choose_multiple(&mut rng, 2);
            let new_name2 = (0..=999).choose(&mut rng).unwrap();
            let new_name = new_name1.into_iter().collect::<String>() + &format!("{:03}", new_name2);
            let mut names_used = NAMES_USED.lock().unwrap();
            if !names_used.contains(&new_name) {
                names_used.insert(new_name.clone());
                break Self(new_name);
            }
        }
    }

    pub fn name(&self) -> &str {
        &self.0
    }

    pub fn reset_name(&mut self) {
        *self = Self::new();
    }
}
