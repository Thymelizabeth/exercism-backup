import gleam/bool.{to_int, guard}
import gleam/list.{fold, zip}
import gleam/string.{length, to_graphemes}

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  use <- guard(when: length(strand1) != length(strand2), return: Error(Nil))
  Ok(zip(to_graphemes(strand1), to_graphemes(strand2))
  |> fold(0, fn(acc, value) {
    let #(v1, v2) = value
    acc + to_int(v1 != v2)
  }))
}
