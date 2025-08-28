module Hamming exposing (distance)

import List exposing (length, filter, map2)
import String exposing (length, toList)

distance : String -> String -> Result String Int
distance left right =
    if String.length left /= String.length right 
        then 
            Err "strands must be of equal length"
        else
            Ok <| List.length <| filter identity <| map2 (/=) (toList left) (toList right)
