import gleam/int.{to_string}
import gleam/list.{fold}

pub fn convert(number: Int) -> String {
  let sound_list = [ #(3, "Pling")
                  , #(5, "Plang")
                  , #(7, "Plong")
                  ]
  case fold(sound_list, "", fn(acc, x) { divisors_to_string(number, x, acc) }) {
    "" -> to_string(number)
    word -> word
  }
}

fn divisors_to_string(n: Int, x: #(Int, String), acc: String) {
  acc <> case n % x.0 {
    0 -> x.1
    _ -> ""
  }
}