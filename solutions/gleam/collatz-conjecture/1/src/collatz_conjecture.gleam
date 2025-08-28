pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number {
    1 -> Ok(0)
    n if n < 1 -> Error(NonPositiveNumber)
    n -> Ok(steps_acc(n, 0))
  }
}

fn steps_acc(number: Int, step_count: Int) -> Int {
  case number {
    1 -> step_count
    n if n % 2 == 0 -> steps_acc(n / 2, step_count + 1)
    n -> steps_acc({3 * n} + 1, step_count + 1)
  }
}