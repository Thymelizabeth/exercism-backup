module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)

expectedMinutesInOven : Int
expectedMinutesInOven = 40

minutesPerLayer : Int
minutesPerLayer = 2

preparationTimeInMinutes : Int -> Int
preparationTimeInMinutes layers = minutesPerLayer * layers

elapsedTimeInMinutes : Int -> Int -> Int
elapsedTimeInMinutes layers ovenTime = ovenTime + preparationTimeInMinutes layers