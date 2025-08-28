module Phone (number) where
import Data.Char (isDigit)

number :: String -> Maybe String
number = (\x -> if isValidNANP x then if length x == 11 then Just (tail x) else Just x else Nothing) . filter isDigit

isValidNANP :: String -> Bool
isValidNANP x
  | length x == 11 = head x == '1' && isValidNANP (tail x)
  | length x == 10 = read [head x] > 1 && read [x !! 3] > 1
  | otherwise = False