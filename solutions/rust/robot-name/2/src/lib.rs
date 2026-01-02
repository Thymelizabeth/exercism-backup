use rand::{
    Rng,
    distr::{Alphabetic, SampleString},
};
use std::{cell::RefCell, collections::HashSet, rc::Rc};

/// A `RobotFactory` is responsible for ensuring that all robots produced by
/// it have a unique name. Robots from different factories can have the same
/// name.
pub struct RobotFactory(Rc<RefCell<HashSet<String>>>);

pub struct Robot {
    name: String,
    used_names: Rc<RefCell<HashSet<String>>>,
}

impl RobotFactory {
    pub fn new() -> Self {
        Self(Rc::new(RefCell::new(HashSet::new())))
    }

    pub fn new_robot<R: Rng>(&mut self, rng: &mut R) -> Robot {
        let mut robot = Robot {
            name: String::new(),
            used_names: self.0.clone(),
        };
        robot.reset(rng);
        robot
    }
}

impl Robot {
    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn reset<R: Rng>(&mut self, rng: &mut R) {
        self.name = loop {
            let new_name = format!(
                "{}{:03}",
                Alphabetic.sample_string(rng, 2).to_uppercase(),
                rng.random_range(0..=999)
            );
            if self.used_names.borrow_mut().insert(new_name.clone()) {
		self.used_names.borrow_mut().remove(&self.name);
                break new_name;
            }
        };
    }
}
