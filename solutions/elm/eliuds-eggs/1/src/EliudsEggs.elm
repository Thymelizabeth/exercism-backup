module EliudsEggs exposing (eggCount)

import Bitwise

eggCount : Int -> Int
eggCount n =
    List.range 0 (ceiling <| logBase 2 <| toFloat n)
        |> List.map ((^) 2)
        |> List.map (Bitwise.and n)
        |> List.filter ((/=) 0)
        |> List.length
