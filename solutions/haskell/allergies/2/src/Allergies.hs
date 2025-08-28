module Allergies (Allergen(..), allergies, isAllergicTo) where

import qualified Data.Map.Lazy as Map

data Allergen = Eggs
              | Peanuts
              | Shellfish
              | Strawberries
              | Tomatoes
              | Chocolate
              | Pollen
              | Cats
              deriving (Eq, Show)

allergyMap :: Map.Map Int Allergen
allergyMap = Map.fromList [ (1, Eggs)
                          , (2, Peanuts)
                          , (4, Shellfish)
                          , (8, Strawberries)
                          , (16, Tomatoes)
                          , (32, Chocolate)
                          , (64, Pollen)
                          , (128, Cats)
                          ]

allergies :: Int -> [Allergen]
allergies score | score <= 0 = []
                | score > sum (Map.keys allergyMap) = allergies (score - sum (Map.keys allergyMap) - 1)
                | otherwise = snd $ Map.foldrWithKey (\k v (score', acc) -> if score' `div` k == 1 then (score' - k, v : acc) else (score', acc)) (score, []) allergyMap

isAllergicTo :: Allergen -> Int -> Bool
isAllergicTo allergen score = allergen `elem` allergies score
