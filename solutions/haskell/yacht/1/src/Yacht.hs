module Yacht (yacht, Category(..)) where

import Data.List (sort)
import Data.Maybe (listToMaybe)

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht category = case category of
  Ones -> numberOf 1
  Twos -> numberOf 2
  Threes -> numberOf 3
  Fours -> numberOf 4
  Fives -> numberOf 5
  Sixes -> numberOf 6
  FullHouse -> fullHouse
  FourOfAKind -> kind4
  LittleStraight -> straight [1,2,3,4,5]
  BigStraight -> straight [2,3,4,5,6]
  Choice -> sum
  Yacht -> kind5

countElem :: Eq a => a -> [a] -> Int
countElem n = length . filter (==n)

numberOf :: Int -> [Int] -> Int
numberOf n = (n *) . countElem n

fullHouse :: [Int] -> Int
fullHouse dice = if 3 `elem` diceCount && 2 `elem` diceCount then sum dice else 0
  where diceCount = map (\d -> countElem d dice) [1..6]

kind4 :: [Int] -> Int
kind4 dice = maybe 0 (4 *) $ listToMaybe $ filter (\d -> countElem d dice >= 4) dice

straight :: [Int] -> [Int] -> Int
straight combo dice = if sort dice == combo
                      then 30
                      else 0

kind5 :: [Int] -> Int
kind5 (d:ds) = 
  if all (==d) ds
  then 50
  else 0