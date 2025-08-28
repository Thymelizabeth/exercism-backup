module Darts (score) where

score :: Float -> Float -> Int
score x y
  | h <= 1 = 10
  | h <= 5 = 5
  | h <= 10 = 1
  | otherwise = 0
  where h = sqrt (x ^ 2 + y ^ 2)
