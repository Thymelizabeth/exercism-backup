module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n
  | n <= 0 = Nothing
  | otherwise = case compare n $ sum [x | x <- [1..n - 1], mod n x == 0] of
    GT -> Just Deficient
    EQ -> Just Perfect
    LT -> Just Abundant
