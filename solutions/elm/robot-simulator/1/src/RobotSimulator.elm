module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


turnRight : Robot -> Robot
turnRight robot =
    { robot
        | bearing =
            case robot.bearing of
                North ->
                    East

                East ->
                    South

                South ->
                    West

                West ->
                    North
    }


turnLeft : Robot -> Robot
turnLeft robot =
    { robot
        | bearing =
            case robot.bearing of
                North ->
                    West

                West ->
                    South

                South ->
                    East

                East ->
                    North
    }


advance : Robot -> Robot
advance ({ bearing, coordinates } as robot) =
    let
        ( dx, dy ) =
            case bearing of
                North ->
                    ( 0, 1 )

                East ->
                    ( 1, 0 )

                South ->
                    ( 0, -1 )

                West ->
                    ( -1, 0 )
    in
    { robot | coordinates = { x = coordinates.x + dx, y = coordinates.y + dy } }


simulate : String -> Robot -> Robot
simulate directions robot =
    String.foldl
        (\instruction r ->
            case instruction of
                'A' ->
                    advance r

                'L' ->
                    turnLeft r

                'R' ->
                    turnRight r

                _ ->
                    r
        )
        robot
        directions
