module MariosMarvellousLasagna exposing (remainingTimeInMinutes)

remainingTimeInMinutes : Int -> Int -> Int
remainingTimeInMinutes layers minutesSinceStart =
    let
        expectedMinutesInOven =
            40
        minutesPerLayer =
            2
        preparationTimeInMinutes layers_ =
            layers_ * minutesPerLayer
    in
        preparationTimeInMinutes layers + expectedMinutesInOven - minutesSinceStart
                    