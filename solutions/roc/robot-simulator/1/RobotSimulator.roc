module [create, move]

Direction : [North, East, South, West]
Robot : { x : I64, y : I64, direction : Direction }

create : { x ?? I64, y ?? I64, direction ?? Direction } -> Robot
create = |{ x ?? 0, y ?? 0, direction ?? North }|
    { x, y, direction }

move : Robot, Str -> Robot
move = |robot, instructions|
    Str.walk_utf8(instructions, robot, |acc, instruction|
        when instruction is
            'R' -> turn_right(acc)
            'L' -> turn_left(acc)
            'A' -> advance(acc)
            _ -> crash "Invalid instruction"
    )

turn_right : Robot -> Robot
turn_right = |robot| 
    when robot.direction is
        North -> { robot & direction: East }
        East -> { robot & direction: South }
        South -> { robot & direction: West }
        West -> { robot & direction: North }

turn_left : Robot -> Robot
turn_left = |robot|
    robot
    |> turn_right
    |> turn_right
    |> turn_right

advance : Robot -> Robot
advance = |robot|
    when robot.direction is
        North -> { robot & y: robot.y + 1 }
        South -> { robot & y: robot.y - 1 }
        East -> { robot & x: robot.x + 1 }
        West -> { robot & x: robot.x - 1 }