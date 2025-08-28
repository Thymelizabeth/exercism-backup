module Allergies exposing (Allergy(..), isAllergicTo, toList)

import Bitwise
import Dict exposing (Dict(..))


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


allergyList : List Allergy
allergyList =
    [ Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats ]


allergyMap : Dict Int Allergy
allergyMap =
    allergyList
        |> List.map2 Tuple.pair
            (List.range 0 (List.length allergyList - 1)
                |> List.map (\x -> Bitwise.shiftLeftBy x 1)
            )
        |> Dict.fromList


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    toList score
        |> List.member allergy


toList : Int -> List Allergy
toList score =
    if score <= 0 then
        []

    else if score > List.sum (Dict.keys allergyMap) then
        toList <| score - List.sum (Dict.keys allergyMap) - 1

    else
        allergyMap
            |> Dict.foldr
                (\k v ( score_, acc ) ->
                    if Bitwise.and score_ k /= 0 then
                        ( score_ - k, v :: acc )

                    else
                        ( score_, acc )
                )
                ( score, [] )
            |> Tuple.second
