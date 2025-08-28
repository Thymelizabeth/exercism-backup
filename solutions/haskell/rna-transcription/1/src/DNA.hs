module DNA (toRNA) where
import Data.Either (partitionEithers)

toRNA :: String -> Either Char String
toRNA = (\(l,r) -> if null l then Right r else Left $ head l) . partitionEithers . map toComplement

toComplement :: Char -> Either Char Char
toComplement 'G' = Right 'C'
toComplement 'C' = Right 'G'
toComplement 'T' = Right 'A'
toComplement 'A' = Right 'U'
toComplement  x  = Left x