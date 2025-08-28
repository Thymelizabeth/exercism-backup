import gleam/list.{try_map}
import gleam/result.{map}
import gleam/string.{concat, to_graphemes}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> to_graphemes()
  |> try_map(fn(nucleotide) {
    case complement(nucleotide) {
      "" -> Error(Nil)
      x -> Ok(x)
    }
  })
  |> map(fn(x) { concat(x) })
}

fn complement(nucleotide: String) -> String {
  case nucleotide {
    "G" -> "C"
    "C" -> "G"
    "T" -> "A"
    "A" -> "U"
    _ -> ""
  }
}