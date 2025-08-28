import gleam/list.{try_map}
import gleam/result.{map}
import gleam/string.{concat, to_graphemes}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> to_graphemes()
  |> try_map(complement)
  |> map(concat)
}

fn complement(nucleotide: String) -> Result(String, Nil) {
  case complement_inner(nucleotide) {
    "" -> Error(Nil)
    x -> Ok(x)
  }
}

fn complement_inner(nucleotide: String) -> String {
  case nucleotide {
    "G" -> "C"
    "C" -> "G"
    "T" -> "A"
    "A" -> "U"
    _ -> ""
  }
}