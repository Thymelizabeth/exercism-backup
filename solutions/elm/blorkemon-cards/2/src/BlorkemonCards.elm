module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : { a | power : Int } -> { a | power : Int } -> Bool
isMorePowerful =
    on (>) .power


maxPower : { a | power : comparable } -> { a | power : comparable } -> comparable
maxPower =
    on max .power


sortByMonsterName : List { a | monster : comparable } -> List { a | monster : comparable }
sortByMonsterName =
    List.sortBy .monster


sortByCoolness : List { a | shiny : Bool, power : comparable } -> List { a | shiny : Bool, power : comparable }
sortByCoolness =
    List.reverse << List.sortBy (\card -> ( toInt card.shiny, card.power ))


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    case on compare .power card1 card2 of
        EQ ->
            on compare (toInt << .shiny) card1 card2

        o ->
            o


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    case compareShinyPower card1 card2 of
        EQ ->
            "too close to call"

        LT ->
            card2.monster

        GT ->
            card1.monster


on : (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f x y =
    op (f x) (f y)


toInt : Bool -> Int
toInt x =
    if x then
        1

    else
        0
