module RnaTranscription
  ( toRNA
  ) where

import Prelude
import Data.Traversable (traverse)
import Data.String.CodeUnits (fromCharArray, toCharArray)
import Data.Maybe (Maybe(..))

toRNA :: String -> Maybe String
toRNA = map fromCharArray <<< traverse complement <<< toCharArray

complement :: Char -> Maybe Char
complement c = case c of
  'G' -> Just 'C'
  'C' -> Just 'G'
  'T' -> Just 'A'
  'A' -> Just 'U'
  _ -> Nothing