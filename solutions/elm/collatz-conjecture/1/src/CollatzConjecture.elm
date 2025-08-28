module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz start =
    if start < 1 then
        Err "Only positive integers are allowed"

    else
        Ok <| collatzAcc start 0


collatzAcc : Int -> Int -> Int
collatzAcc n steps =
    if n == 1 then
        steps

    else
        collatzAcc
            (if modBy 2 n == 0 then
                n // 2

             else
                n * 3 + 1
            )
            (steps + 1)
