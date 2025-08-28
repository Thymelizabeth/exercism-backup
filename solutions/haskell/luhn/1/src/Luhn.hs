module Luhn (isValid) where
import Data.Char (isSpace, isDigit)

isValid :: String -> Bool
isValid n = length (filter (not . isSpace) n) > 1 && all (\x -> isSpace x || isDigit x) n && sum (secondDouble $ reverse $ map (\x -> read [x]) $ filter (not . isSpace) n) `mod` 10 == 0

secondDouble :: [Int] -> [Int]
secondDouble [] = []
secondDouble (x:y:xs) = if y >= 5 then x:y * 2 - 9:secondDouble xs else x:y * 2:secondDouble xs
secondDouble (x:_) = [x]