module Accumulate

let rec accumulate (func: 'a -> 'b) (input: 'a list): 'b list =
    match input with
    | [] -> []
    | x::xs -> func x :: accumulate func xs
