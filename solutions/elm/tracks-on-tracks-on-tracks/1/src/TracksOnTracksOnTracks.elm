module TracksOnTracksOnTracks exposing (..)


newList : List String
newList = []


existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage language languages =
    language :: languages


countLanguages : List String -> Int
countLanguages languages =
    List.length languages


reverseList : List String -> List String
reverseList languages =
    List.reverse languages


excitingList : List String -> Bool
excitingList languages =
    List.take 1 languages == ["Elm"] || List.drop 1 (List.take 2 languages) == ["Elm"] && countLanguages languages < 4
