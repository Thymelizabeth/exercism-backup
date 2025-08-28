module ResistorColors (Color(..), Resistor(..), label, ohms) where

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
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

label :: Resistor -> String
label resistor = case ohms resistor of
  v | v > 1000000000 -> show (v `div` (10 ^ 9)) <> " gigaohms"
    | v > 1000000 -> show (v `div` (10 ^ 6)) <> " megaohms"
    | v > 1000 -> show (v `div` (10 ^ 3)) <> " kiloohms"
    | otherwise -> show v <> " ohms"

ohms :: Resistor -> Int
ohms (Resistor (val1, val2, exponent)) = (fromEnum val1 * 10 + fromEnum val2) * 10 ^ (fromEnum exponent)


