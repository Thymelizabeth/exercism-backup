import gleam/bit_array
import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0
    Cytosine -> 1
    Guanine -> 2
    Thymine -> 3
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0 -> Ok(Adenine)
    1 -> Ok(Cytosine)
    2 -> Ok(Guanine)
    3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(encode_nucleotide)
  |> list.map(fn(nucleotide) { <<nucleotide:2>> })
  |> bit_array.concat()
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case bit_array.bit_size(dna) % 2 == 0 {
    True -> {
      dna
      |> to_nucleotides()
      |> list.try_map(decode_nucleotide)
    }
    False -> Error(Nil)
  }
}

fn to_nucleotides(dna: BitArray) -> List(Int) {
  case dna {
    <<nucleotide:2, rest:bits>> -> [nucleotide, ..to_nucleotides(rest)]
    _ -> []
  }
}
