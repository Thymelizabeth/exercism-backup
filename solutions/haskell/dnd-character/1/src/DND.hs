module DND ( Character(..)
           , ability
           , modifier
           , character
           ) where

import Control.Monad (replicateM)
import Data.List (delete)
import System.Random (Random)
import Test.QuickCheck (Gen, chooseInt)



data Character = Character
  { strength     :: Int
  , dexterity    :: Int
  , constitution :: Int
  , intelligence :: Int
  , wisdom       :: Int
  , charisma     :: Int
  , hitpoints    :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier n = floor $ fromIntegral (n - 10) / 2

ability :: Gen Int
ability = do
  v <- sequence $ map (const getDiceRoll) [1..4]
  return $ sum v - minimum v

getDiceRoll :: Gen Int
getDiceRoll = chooseInt (1,6)

character :: Gen Character
character = do
  str <- ability
  dex <- ability
  con <- ability
  int <- ability
  wis <- ability
  cha <- ability
  return $ Character str dex con int wis cha $ 10 + modifier con