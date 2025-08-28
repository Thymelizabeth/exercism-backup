pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  a == b && b == c && c >. 0.0
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  {a == b || b == c || a == c} && a +. b >=. c && b +. c >=. a && a +. c >=. b && a >. 0.0 && b >. 0.0 && c >. 0.0
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  a != b && b != c && a != c && a +. b >=. c && b +. c >=. a && a +. c >=. b && a >. 0.0 && b >. 0.0 && c >. 0.0
}
