import gleam/list.{try_map}
import gleam/result.{map}
import gleam/string.{join, to_graphemes}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> to_graphemes()
  |> try_map(fn(nucleotide) {
    case nucleotide {
      "G" -> Ok("C")
      "C" -> Ok("G")
      "T" -> Ok("A")
      "A" -> Ok("U")
      _   -> Error(Nil)
    }
  })
  |> map(fn(x) { join(x, with: "") })
}
