module Scrabble (scoreLetter, scoreWord) where
import Data.Char (toLower)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (fromMaybe)

scoreMap :: Map Char Integer
scoreMap = M.fromList $ zip ['a'..'z'] [1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10]

scoreLetter :: Char -> Integer
scoreLetter = fromMaybe 0 . flip M.lookup scoreMap . toLower

scoreWord :: String -> Integer
scoreWord = sum . map scoreLetter
