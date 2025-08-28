import gleam/int.{add, multiply}
import gleam/list
import gleam/set.{type Set}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors
  |> list.map(fn(factor) { create_multiples(factor, limit)})
  |> list.fold(set.new(), set.union)
  |> set.fold(0, add)
}

fn create_multiples(factor: Int, limit: Int) -> Set(Int) {
  list.range(1, limit / factor)
  |> list.map(fn(x) { factor * x })
  |> list.filter(fn(x) { x < limit })
  |> set.from_list
}