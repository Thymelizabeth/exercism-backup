import gleam/result.{unwrap}
import gleam/list.{try_map}
import gleam/int.{power, to_float}
import gleam/float.{truncate}

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  case try_map(colors, translate_colour) {
    Ok([v1, v2, e, ..]) -> Ok(convert_unit(Resistance("ohms", v1 * 10 + v2), e))
    _               -> Error(Nil)
  }
}

fn translate_colour(colour: String) -> Result(Int, Nil) {
  case colour {
    "black"  -> Ok(0)
    "brown"  -> Ok(1)
    "red"    -> Ok(2)
    "orange" -> Ok(3)
    "yellow" -> Ok(4)
    "green"  -> Ok(5)
    "blue"   -> Ok(6)
    "violet" -> Ok(7)
    "grey"   -> Ok(8)
    "white"  -> Ok(9)
    _        -> Error(Nil)
  }
}

fn convert_unit(resistance: Resistance, exponent: Int) -> Resistance {
    case resistance.value {
      0 -> Resistance("ohms", 0)
      x if x % 10 == 0 -> convert_unit(Resistance(..resistance, value: resistance.value / 10), exponent + 1)
      v -> case exponent {
        0 | 1 | 2 -> Resistance(..resistance, value: v * truncate(unwrap(power(10, to_float(exponent)), 0.0)))
        3 | 4 | 5 -> convert_unit(Resistance(..resistance, unit: "kiloohms"), exponent - 3)
        6 | 7 | 8 -> convert_unit(Resistance(..resistance, unit: "megaohms"), exponent - 6)
        _ -> convert_unit(Resistance(..resistance, unit: "gigaohms"), exponent - 9)
    }
  }
}