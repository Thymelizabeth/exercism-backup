module Bob (responseFor) where
import qualified Data.Text as T
import Data.Char (isUpper, isSpace, isPunctuation, isLetter)

responseFor :: T.Text -> T.Text
responseFor xs
  | T.null xs || T.all isSpace xs = T.pack "Fine. Be that way!"
  | T.isSuffixOf (T.singleton '?') (T.stripEnd xs) && T.all isUpper (T.filter isLetter xs) && T.any isLetter xs = T.pack "Calm down, I know what I'm doing!"
  | T.all isUpper (T.filter isLetter xs) && T.any isLetter xs = T.pack "Whoa, chill out!"
  | T.isSuffixOf (T.singleton '?') (T.stripEnd xs) = T.pack "Sure."
  | otherwise = T.pack "Whatever."