module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName =
    Dict.update playerName (Just << (+) 1 << Maybe.withDefault 0)


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers =
    List.foldl updateGoalCountForPlayer Dict.empty


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold =
    Dict.filter (\_ v -> v >= goalThreshold)


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName =
    Dict.insert playerName 0


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName =
    Dict.get playerName >>
    Maybe.withDefault 0 >>
    String.fromInt >>
    String.append (playerName ++ ": ")


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    Dict.keys players |>
    List.map (\name -> formatPlayer name players) |>
    String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    Dict.merge Dict.insert (\k v1 v2 -> Dict.insert k (v1 + v2)) Dict.insert game1 game2 Dict.empty
