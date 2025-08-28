import gleam/int.{sum, digits}
import gleam/list.{length}
import gleam/result.{unwrap}

pub fn is_armstrong_number(number: Int) -> Bool {
  let digit_list = unwrap(digits(number, 10), [])
  number
  == {
    list.map(digit_list, fn(x) {
      power(x, length(digit_list))
      |> unwrap(0)
    })
    |> sum
  }
}

fn power(base: Int, of exponent: Int) -> Result(Int, Nil) {
  power_acc(base, exponent, 1)
}

fn power_acc(base: Int, exponent: Int, acc: Int) -> Result(Int, Nil) {
  case exponent {
    n if n < 0 -> Error(Nil)
    0 -> Ok(acc)
    _ -> power_acc(base, exponent - 1, acc * base)
  }
}
