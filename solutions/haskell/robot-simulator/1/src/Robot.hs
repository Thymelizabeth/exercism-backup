module Robot
    ( Bearing(..)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where
import Data.Bifunctor (second,first)
import Data.List (foldl')

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot
  { bearing :: Bearing
  , coordinates :: (Integer,Integer)
  }


mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction position = Robot { bearing = direction, coordinates = position}

move :: Robot -> String -> Robot
move robot instructions = foldl' move' robot instructions

move' :: Robot -> Char -> Robot
move' robot c = case c of
  'A' -> advance robot
  'L' -> turnLeft robot
  'R' -> turnRight robot
  _   -> robot

advance :: Robot -> Robot
advance robot@(Robot { coordinates = oldPos, bearing = direction }) = case direction of
  North -> robot { coordinates = second (+1) oldPos }
  South -> robot { coordinates = second (subtract 1) oldPos }
  East  -> robot { coordinates = first  (+1) oldPos }
  West  -> robot { coordinates = first  (subtract 1) oldPos }

turnLeft :: Robot -> Robot
turnLeft robot = case bearing robot of
  North -> robot { bearing = West  }
  West  -> robot { bearing = South }
  South -> robot { bearing = East  }
  East  -> robot { bearing = North }

turnRight :: Robot -> Robot
turnRight robot = case bearing robot of
  North -> robot { bearing = East  }
  East  -> robot { bearing = South }
  South -> robot { bearing = West  }
  West  -> robot { bearing = North }