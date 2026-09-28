import gleam/list.{Continue, Stop}
import gleam/result
import gleam/string

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  rna 
  |> string.to_utf_codepoints
  |> list.sized_chunk(3)
  |> list.map(string.from_utf_codepoints)
  |> list.fold_until(Ok([]), fn(acc, codon) {
    case acc {
      Ok(acc_inner) -> case codon {
        "AUG" -> Continue(Ok(["Methionine", ..acc_inner]))
        "UUU" | "UUC" -> Continue(Ok(["Phenylalanine", ..acc_inner]))
        "UUA" | "UUG" -> Continue(Ok(["Leucine", ..acc_inner]))
        "UCU" | "UCC" | "UCA" | "UCG" -> Continue(Ok(["Serine", ..acc_inner]))
        "UAU" | "UAC" -> Continue(Ok(["Tyrosine", ..acc_inner]))
        "UGU" | "UGC" -> Continue(Ok(["Cysteine", ..acc_inner]))
        "UGG" -> Continue(Ok(["Tryptophan", ..acc_inner]))
        "UAA" | "UAG" | "UGA" -> Stop(acc)
        _ -> Stop(Error(Nil))
      }
      _ -> Stop(Error(Nil))
    }
  })
  |> result.map(list.reverse)
}
