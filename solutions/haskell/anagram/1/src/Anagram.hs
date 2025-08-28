module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.List (sort)

anagramsFor :: String -> [String] -> [String]
anagramsFor xs = filter (isAnagramOf (map toLower xs) . map toLower)

isAnagramOf :: String -> String -> Bool
isAnagramOf xs candidate 
  | length xs /= length candidate = False
  | xs == candidate = False
  | sort xs == sort candidate = True
  | otherwise = False