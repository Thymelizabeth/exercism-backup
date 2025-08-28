module CustomSet
  ( delete
  , difference
  , empty
  , fromList
  , insert
  , intersection
  , isDisjointFrom
  , isSubsetOf
  , member
  , null
  , size
  , toList
  , union
  ) where

import Prelude hiding (null)

newtype CustomSet a = CustomSet [a] deriving (Eq, Show, Ord)

delete :: Ord a => a -> CustomSet a -> CustomSet a
delete _ (CustomSet []) = CustomSet []
delete n (CustomSet (x:xs))
  | n < x  = CustomSet (x:xs)
  | n == x = CustomSet xs
  | n > x  = insert x $ delete n (CustomSet xs)

difference :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
difference setA setB = CustomSet $ filter (not . flip member setB) $ toList setA

empty :: CustomSet a
empty = CustomSet []

fromList :: Ord a => [a] -> CustomSet a
fromList = foldr insert empty

insert :: Ord a => a -> CustomSet a -> CustomSet a
insert n (CustomSet []) = CustomSet [n]
insert n (CustomSet (x:xs))
  | n < x  = CustomSet $ n:x:xs
  | n == x = CustomSet $   x:xs
  | n > x  = insert x $ insert n (CustomSet xs)

intersection :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
intersection setA = CustomSet . filter (`member` setA) . toList

isDisjointFrom :: Ord a => CustomSet a -> CustomSet a -> Bool
isDisjointFrom setA = all (not . flip member setA) . toList

isSubsetOf :: Ord a => CustomSet a -> CustomSet a -> Bool
isSubsetOf setA setB = all (flip member setB) $ toList setA

member :: Ord a => a -> CustomSet a -> Bool
member _ (CustomSet []) = False
member n (CustomSet (x:xs))
  | n < x  = False
  | n == x = True
  | n > x  = member n (CustomSet xs)

null :: Eq a => CustomSet a -> Bool
null set = set == empty

size :: CustomSet a -> Int
size = length . toList

toList :: CustomSet a -> [a]
toList (CustomSet xs) = xs

union :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
union (CustomSet []) setB = setB
union (CustomSet (x:xs)) setB = union (CustomSet xs) $ insert x setB
