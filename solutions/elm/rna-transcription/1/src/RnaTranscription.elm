module RnaTranscription exposing (toRNA)


toRNA : String -> Result String String
toRNA = 
    String.toList >>
    List.map charToRNA >>
    List.foldr (\rc (l, r) -> case rc of
                                Ok c -> (l, String.cons c r)
                                Err c -> (String.cons c l, r)) ("", "") >>
    (\(l, r) -> if String.isEmpty l then Ok r else Err l)
    

charToRNA : Char -> Result Char Char
charToRNA c = case c of
                'G' -> Ok  'C'
                'C' -> Ok  'G'
                'T' -> Ok  'A'
                'A' -> Ok  'U'
                x   -> Err x
    
