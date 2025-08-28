module ArmstrongNumbers exposing (digits, isArmstrongNumber)


isArmstrongNumber : Int -> Bool
isArmstrongNumber nb =
    if nb < 10 then
        True

    else
        let
            ns =
                digits nb
        in
        nb
            == (ns
                    |> List.map (\n -> n ^ List.length ns)
                    |> List.sum
               )


digits : Int -> List Int
digits =
    List.reverse << digitsInner


digitsInner : Int -> List Int
digitsInner n =
    if n < 10 then
        [ n ]

    else
        modBy 10 n :: digitsInner (n // 10)
