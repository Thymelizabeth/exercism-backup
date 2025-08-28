module [distance]

distance : Str, Str -> Result U64 [DifferentLengths]
distance = |str_strand1, str_strand2|
    strand1 = Str.to_utf8(str_strand1)
    strand2 = Str.to_utf8(str_strand2)
    if List.len(strand1) == List.len(strand2) then
        List.map2(strand1, strand2, Pair)
        |> List.count_if(|Pair a b| a != b)
        |> Ok
    else
        Err DifferentLengths
