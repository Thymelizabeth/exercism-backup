module ResistorColors (Color(..), value) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Eq, Show, Enum, Bounded)

value :: (Color, Color) -> Int
value (a, b) = (\[x,y] -> x * 10 + y) $ map fromEnum [a,b]
