module Accumulate
  ( accumulate
  ) where

import Data.List (List(..))

accumulate :: forall a b. (a -> b) -> List a -> List b
accumulate f vs = case vs of
  Nil -> Nil
  Cons x xs -> Cons (f x) (accumulate f xs)
