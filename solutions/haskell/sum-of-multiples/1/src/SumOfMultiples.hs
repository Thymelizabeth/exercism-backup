module SumOfMultiples (sumOfMultiples) where
import Data.List (union)

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum $ foldr union [] $ map (\x -> if x == 0 then [0] else [n | n <- [x,2 * x..limit - 1]]) factors