use core::ops::Add;

pub struct Triangle<T>(T, T, T);

impl<T> Triangle<T>
where
    T: PartialEq + Add + From<u8> + Copy,
    <T as Add>::Output: PartialOrd<T>,
{
    pub fn build(sides: [T; 3]) -> Option<Triangle<T>> {
        if sides[0] == 0.into()
            || sides[1] == 0.into()
            || sides[2] == 0.into()
            || sides[0] + sides[1] < sides[2]
            || sides[0] + sides[2] < sides[1]
            || sides[1] + sides[2] < sides[0]
        {
            None
        } else {
            Some(Triangle(sides[0], sides[1], sides[2]))
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
