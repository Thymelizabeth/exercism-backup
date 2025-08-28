pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  case colors {
    [val1, val2, ..] -> Ok(to_int(val1) * 10 + to_int(val2))
    _ -> Error(Nil)
  }
}

fn to_int(colour: Color) -> Int {
  case colour {
    Black  -> 0
    Brown  -> 1
    Red    -> 2
    Orange -> 3
    Yellow -> 4
    Green  -> 5
    Blue   -> 6
    Violet -> 7
    Grey   -> 8
    White  -> 9
  }
}