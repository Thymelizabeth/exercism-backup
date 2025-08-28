module ProteinTranslation

open System.Collections.Generic

let toProtein codon =
    match codon with
    | "AUG" -> "Methionine"
    | "UUU" | "UUC" -> "Phenylalanine"
    | "UUA" | "UUG" -> "Leucine"
    | "UCU" | "UCC" | "UCA" | "UCG" -> "Serine"
    | "UAU" | "UAC" -> "Tyrosine"
    | "UGU" | "UGC" -> "Cysteine"
    | "UGG" -> "Tryptophan"
    | "UAA" | "UAG" | "UGA" -> "STOP"
    | _ -> failwith "Invalid codon"

let proteins (rna: string) =
    rna
    |> Seq.toList
    |> List.chunkBySize 3
    |> List.map (fun x -> System.String.Join("", x))
    |> List.map toProtein
    |> List.takeWhile (fun x -> not (x.Equals("STOP")))

