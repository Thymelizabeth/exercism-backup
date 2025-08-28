{-# LANGUAGE OverloadedStrings #-}

module Forth
  ( ForthError(..)
  , ForthState
  , evalText
  , toList
  , emptyState
  ) where

import Data.List.NonEmpty (nonEmpty)
import Data.Map (Map(..))
import qualified Data.Map as M
import Data.Maybe (isJust)
import Data.Semigroup (sconcat)
import Data.Text (Text, intercalate, splitOn)
import Text.Read (readMaybe)

data ForthError
     = DivisionByZero
     | StackUnderflow
     | InvalidWord
     | UnknownWord Text
     deriving (Show, Eq)

data ForthState a = ForthState [a] (WordList a)

type ForthWord a = ForthState a -> Either ForthError (ForthState a)
type WordList a = Map Text (ForthWord a)

initialDict :: Integral a => WordList a
initialDict = M.fromList [ ("+", forthPlus)
                          , ("-", forthMinus)
                          , ("*", forthTimes)
                          , ("/", forthDiv)
                          , ("DUP", forthDup)
                          , ("DROP", forthDrop)
                          , ("SWAP", forthSwap)
                          , ("OVER", forthOver)
                          ]
forthPlus :: Num a => ForthWord a
forthPlus (ForthState (x:y:xs) dict) = Right $ ForthState (x+y : xs) dict
forthPlus _ = Left StackUnderflow

forthMinus :: Num a => ForthWord a
forthMinus (ForthState (x:y:xs) dict) = Right $ ForthState (y-x : xs) dict
forthMinus _ = Left StackUnderflow

forthTimes :: Num a => ForthWord a
forthTimes (ForthState (x:y:xs) dict) = Right $ ForthState (x*y : xs) dict
forthTimes _ = Left StackUnderflow

forthDiv :: Integral a => ForthWord a
forthDiv (ForthState (x:y:xs) dict) = if x == 0 then Left DivisionByZero else Right $ ForthState (y `div` x : xs) dict
forthDiv _ = Left StackUnderflow

forthDup :: ForthWord a
forthDup (ForthState (x:xs) dict) = Right $ ForthState (x:x:xs) dict
forthDup _ = Left StackUnderflow

forthDrop :: ForthWord a
forthDrop (ForthState (x:xs) dict) = Right $ ForthState xs dict
forthDrop _ = Left StackUnderflow

forthSwap :: ForthWord a
forthSwap (ForthState (x:y:xs) dict) = Right $ ForthState (y:x:xs) dict
forthSwap _ = Left StackUnderflow

forthOver :: ForthWord a
forthOver (ForthState (x:y:xs) dict) = Right $ ForthState (y:x:y:xs) dict
forthOver _ = Left StackUnderflow

emptyState :: Integral a => ForthState a
emptyState = ForthState [] initialDict

evalText :: Text -> ForthState Int -> Either ForthError (ForthState Int)
evalText text state@(ForthState stack dict) =
  case splitOn " " text of
    (":" : wordName : definition) ->
      case readMaybe $ show wordName :: Maybe Int of
        Just _ -> Left InvalidWord
        Nothing -> Right $ ForthState stack $ M.insert wordName (toForthWord (dict M.! wordName) $ map (\x -> if x == wordName then Nothing else Just x) $ take (length definition - 1) definition) dict
    (word : rest) | M.member word dict -> evalText (intercalate " " rest) =<< (dict M.! word) state
    (word : rest) -> case readMaybe $ show word of
      Just immediate -> evalText (intercalate " " rest) $ ForthState (immediate:stack) dict
      Nothing -> Left $ UnknownWord word
    [] -> Right state

toList :: ForthState a -> [a]
toList (ForthState stack _) = stack

toForthWord :: ForthWord Int -> [Maybe Text] -> ForthWord Int
toForthWord word xs = maybe Right (sconcat . fmap (maybe word evalText)) $ nonEmpty xs
