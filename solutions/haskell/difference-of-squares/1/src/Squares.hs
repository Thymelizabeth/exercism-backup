module Squares (difference, squareOfSum, sumOfSquares) where

difference :: Integral a => a -> a
difference n = max s1 s2 - min s1 s2
  where
    s1 = squareOfSum n
    s2 = sumOfSquares n

squareOfSum :: Integral a => a -> a
squareOfSum n = (n * (n + 1) `div` 2) ^ 2

sumOfSquares :: Integral a => a -> a
sumOfSquares n =  n * (2 * n + 1) * (n + 1) `div` 6
