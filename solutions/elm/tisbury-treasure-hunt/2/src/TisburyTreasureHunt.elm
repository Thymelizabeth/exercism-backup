module TisburyTreasureHunt exposing (..)


type alias PlaceLocation =
    ( Char, Int )


type alias TreasureLocation =
    ( Int, Char )


type alias Place a =
    ( String, a )


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation ( x, y ) =
    ( y, x )


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    treasureLocation == placeLocationToTreasureLocation placeLocation


countPlaceTreasures : Place PlaceLocation -> List (Place TreasureLocation) -> Int
countPlaceTreasures place treasures =
    treasures
        |> List.map Tuple.second
        |> List.filter (\x -> x == (placeLocationToTreasureLocation <| Tuple.second place))
        |> List.length


specialCaseSwapPossible : Place TreasureLocation -> Place PlaceLocation -> Place TreasureLocation -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case ( foundTreasure, place, desiredTreasure ) of
        ( "Brass Spyglass", "Abandoned Lighthouse", _ ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater", x ) ->
            case x of
                "Crystal Crab" ->
                    True

                "Glass Starfish" ->
                    True

                _ ->
                    False

        ( "Vintage Pirate Hat", "Harbor Managers Office", x ) ->
            case x of
                "Model Ship in Large Bottle" ->
                    True

                "Antique Glass Fishnet Float" ->
                    True

                _ ->
                    False

        _ ->
            False
