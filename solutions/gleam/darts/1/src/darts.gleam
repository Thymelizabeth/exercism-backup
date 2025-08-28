import gleam/float.{square_root}

pub fn score(x: Float, y: Float) -> Int {
  case square_root({x *. x} +. {y *. y}) {
    Error(Nil) -> -1
    Ok(r) if r <=. 1.0 -> 10
    Ok(r) if r <=. 5.0 -> 5
    Ok(r) if r <=. 10.0 -> 1
    _ -> 0
  }
}
