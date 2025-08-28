import gleam/list.{fold}
import gleam/string.{to_graphemes}

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  fold(to_graphemes(instructions)
      , create(direction, position)
      , fn(robot: Robot, instruction: String) -> Robot {
          let Robot(cur_direction, cur_position) = robot
          let Position(cur_x, cur_y) = cur_position
          case instruction {
            "A" -> create(cur_direction, 
                          case cur_direction {
                            North -> Position(cur_x, cur_y + 1)
                            East  -> Position(cur_x + 1, cur_y)
                            South -> Position(cur_x, cur_y - 1)
                            West  -> Position(cur_x - 1, cur_y)
                          })
            "L" -> create(case cur_direction {
                            North -> West
                            West  -> South
                            South -> East
                            East  -> North
                          },
                          cur_position)
          "R" -> create(case cur_direction {
                          North -> East
                          East  -> South
                          South -> West
                          West  -> North
                        },
                        cur_position)
          _ -> robot
          }
      })
}
