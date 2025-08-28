module Go exposing (..)

import GoSupport exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    game |>
    captureRule |>
    oneStonePerPointRule |> 
    Result.andThen libertyRule |>
    Result.andThen koRule |>
    Result.mapError (\e -> {game | error = e }) |>
    (\result -> case result of
                  Ok game2 -> changePlayer game2
                  Err game2 -> game2
                  )
    
