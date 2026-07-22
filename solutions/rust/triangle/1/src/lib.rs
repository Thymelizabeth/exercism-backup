use core::num::NonZero;

pub struct Triangle(NonZero<u64>, NonZero<u64>, NonZero<u64>);

impl Triangle {
    pub fn build(sides: [u64; 3]) -> Option<Triangle> {
        if sides[0] + sides[1] < sides[2]
            || sides[0] + sides[2] < sides[1]
            || sides[1] + sides[2] < sides[0]
        {
            None
        } else {
            Some(Triangle(
                NonZero::new(sides[0])?,
                NonZero::new(sides[1])?,
                NonZero::new(sides[2])?,
            ))
        }
    }

    pub fn is_equilateral(&self) -> bool {
        self.0 == self.1 && self.1 == self.2
    }

    pub fn is_scalene(&self) -> bool {
        self.0 != self.1 && self.1 != self.2 && self.0 != self.2
    }

    pub fn is_isosceles(&self) -> bool {
        if self.0 != self.1 {
            self.0 == self.2 || self.1 == self.2
        } else if self.0 != self.2 {
            self.0 == self.1 || self.2 == self.1
        } else if self.1 != self.2 {
            self.1 == self.0 || self.2 == self.0
        } else {
            self.is_equilateral()
        }
    }
}
