module Acronym (abbreviate) where
import Data.Char (toUpper, isSpace, isUpper, isPunctuation)
import Data.Maybe (mapMaybe)
import Data.List (uncons)
import qualified Data.Text as T

abbreviate :: String -> String
abbreviate = getFirstLetters . splitWords . clean

getFirstLetters :: [String] -> String
getFirstLetters ws = filter (not . isPunctuation) $ map (toUpper . fst) $ mapMaybe (uncons) $ concatMap (\w -> if not (all isUpper w) && any isUpper w then map (\x -> [x]) (filter isUpper w) else [w]) ws

splitWords :: String -> [String]
splitWords = map T.unpack . T.split (\x -> x == '-' || isSpace x) . T.pack

clean :: String -> String
clean = filter (\x -> x == '-' || not (isPunctuation x))