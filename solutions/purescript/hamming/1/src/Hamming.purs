module Hamming
  ( distance
  ) where

import Prelude
import Data.Array (length, filter, zipWith)
import Data.String (length) as S
import Data.String.CodeUnits (toCharArray)
import Data.Maybe (Maybe(..))

distance :: String -> String -> Maybe Int
distance s1 s2 | S.length s1 /= S.length s2 = Nothing
               | otherwise = Just $ length $ filter identity $ zipWith (/=) (toCharArray s1) (toCharArray s2)