module BinarySearch (find) where

import Data.Array

find :: Ord a => Array Int a -> a -> Maybe Int
find array target = find' array 0 (length array)
  where
    find' xs left right
      | left > right = Nothing
      | mid >= length array = Nothing
      | otherwise = case compare target (xs ! mid) of
          EQ -> Just mid
          LT -> find' xs left (mid - 1)
          GT -> find' xs (mid + 1) right
      where
        mid = (left + right) `div` 2
