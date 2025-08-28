module ReverseString (reverseString) where

reverseString :: String -> String
reverseString [] = []
reverseString xs = last xs : reverseString (init xs)
