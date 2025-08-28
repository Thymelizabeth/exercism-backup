module CollatzConjecture
  ( collatz
  ) where

import Data.Maybe (Maybe(..))
import Data.Ord ((<))
import Data.Eq ((==))
import Data.EuclideanRing (mod, (/))
import Data.Semiring ((+), (*))

collatz :: Int -> Maybe Int
collatz n | n < 1 = Nothing
          | n == 1 = Just 0
          | true = Just (collatzAcc n 0)

collatzAcc :: Int -> Int -> Int
collatzAcc 0 _ = 0
collatzAcc 1 s = s
collatzAcc n s | n `mod` 2 == 0 = collatzAcc (n / 2) (s + 1)
               | true = collatzAcc (3 * n + 1) (s + 1)