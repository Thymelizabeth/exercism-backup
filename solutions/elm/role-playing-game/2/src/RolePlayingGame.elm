module RolePlayingGame exposing (Player, castSpell, introduce, revive)


type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }


introduce : Player -> String
introduce { name } =
    Maybe.withDefault "Mighty Magician" name


revive : Player -> Maybe Player
revive player =
    if player.health > 0 then
        Nothing

    else if player.level >= 10 then
        Just { player | mana = Just 100, health = 100 }

    else
        Just { player | mana = Nothing, health = 100 }


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    case player.mana of
        Nothing ->
            ( { player | health = max 0 (player.health - manaCost) }, 0 )

        Just currentMana ->
            if currentMana < manaCost then
                ( player, 0 )

            else
                ( { player | mana = Just (currentMana - manaCost) }, manaCost * 2 )
