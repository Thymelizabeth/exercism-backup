module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)
import Regex
import String

clean1 : String -> String
clean1 =
    String.replace " " "_"


clean2 : String -> String
clean2 =
    clean1 >>
    Regex.replace (Maybe.withDefault Regex.never <| Regex.fromString "[\\s]") (\_ -> "[CTRL]" )



clean3 : String -> String
clean3 =
    clean2 >>
    Regex.replace (Maybe.withDefault Regex.never <| Regex.fromString "-.") 
                  (.match >> String.toUpper >> String.uncons >> Maybe.withDefault (' ', "") >> Tuple.second)
    

clean4 : String -> String
clean4 =
    clean3 >>
    Regex.replace (Maybe.withDefault Regex.never <| Regex.fromString "\\d") (\_ -> "")


clean : String -> String
clean =
    clean4 >>
    Regex.replace (Maybe.withDefault Regex.never <| Regex.fromString "[\\u03b1-\\u03c9]") (\_ -> "")
