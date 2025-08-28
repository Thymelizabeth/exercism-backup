module Isogram (isIsogram) where
import Data.Char (isLetter, toLower)
import Data.List (nub)

isIsogram :: String -> Bool
isIsogram s = nub s' == s' where s' = map toLower $ filter isLetter s