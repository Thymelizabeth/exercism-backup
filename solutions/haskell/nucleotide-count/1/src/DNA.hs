module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map.Lazy (Map)
import qualified Data.Map.Lazy as M
import Data.Either (isLeft)
import Data.Maybe (fromJust)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldr countNucleotides (Right $ M.fromList [(A,0),(C,0),(G,0),(T,0)])

countNucleotides :: Char -> Either String (Map Nucleotide Int) -> Either String (Map Nucleotide Int)
countNucleotides c m
  | isLeft m = m
  | elem c "ACGT" = M.adjust (+1) (fromJust $ charToNucleotide c) <$> m
  | otherwise = Left "Error: Invalid DNA sequence"

charToNucleotide :: Char -> Maybe Nucleotide
charToNucleotide 'A' = Just A
charToNucleotide 'C' = Just C
charToNucleotide 'G' = Just G
charToNucleotide 'T' = Just T
charToNucleotide  _  = Nothing