import gleam/int.{sum, absolute_value}
import gleam/list.{range, map}

pub fn square_of_sum(n: Int) -> Int {
  square(sum(range(1, n)))
}

pub fn sum_of_squares(n: Int) -> Int {
  sum(map(range(1, n), square))
}

pub fn difference(n: Int) -> Int {
  absolute_value(sum_of_squares(n) - square_of_sum(n))
}

fn square(n: Int) -> Int {
  n * n
}