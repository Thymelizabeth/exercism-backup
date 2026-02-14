module BinarySearch (find) where

import Data.Array

find :: Ord a => Array Int a -> a -> Maybe Int
find array target = find' 0 (length array)
  where
    find' left right
      | left > right = Nothing
      | mid >= length array = Nothing
      | otherwise = case compare target (array ! mid) of
          EQ -> Just mid
          LT -> find' left (mid - 1)
          GT -> find' (mid + 1) right
      where
        mid = (left + right) `div` 2
