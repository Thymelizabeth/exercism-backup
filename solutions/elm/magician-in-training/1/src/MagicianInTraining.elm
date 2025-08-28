module MagicianInTraining exposing (..)

import Array exposing (Array)


getCard : Int -> Array Int -> Maybe Int
getCard =
    Array.get


setCard : Int -> Int -> Array Int -> Array Int
setCard =
    Array.set


addCard : Int -> Array Int -> Array Int
addCard =
    Array.push


removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    Array.append (Array.slice 0 index deck) (Array.slice (index + 1) (Array.length deck) deck)


evenCardCount : Array Int -> Int
evenCardCount deck =
    Array.length (Array.filter (\x -> modBy 2 x == 0) deck)
