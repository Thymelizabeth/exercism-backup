module SecureTreasureChest exposing (Password, SecureTreasureChest, createPassword, createTreasure, getTreasure)


type Password
    = Password String


type SecureTreasureChest treasure
    = SecureTreasureChest Password treasure


createPassword : String -> Maybe Password
createPassword attempt =
    if String.length attempt < 8 then
        Nothing

    else
        Just <| Password attempt


createTreasure : treasure -> Password -> SecureTreasureChest treasure
createTreasure treasure password =
    SecureTreasureChest password treasure


getTreasure : String -> SecureTreasureChest treasure -> Maybe treasure
getTreasure passwordAttempt (SecureTreasureChest (Password password) treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing
