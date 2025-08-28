module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where
import Data.Maybe (listToMaybe)

data BST a = Branch (BST a) [a] (BST a) | Leaf deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Leaf = Nothing
bstLeft (Branch l (_:y:xs) r) = Just $ Branch l (y:xs) r
bstLeft (Branch l _ _) = Just l

bstRight :: BST a -> Maybe (BST a)
bstRight Leaf = Nothing
bstRight (Branch l (_:y:xs) r) = Just $ Branch l (y:xs) r
bstRight (Branch _ _ r) = Just r

bstValue :: BST a -> Maybe a
bstValue Leaf = Nothing
bstValue (Branch _ v _) = listToMaybe v

empty :: BST a
empty = Leaf

fromList :: Ord a => [a] -> BST a
fromList = foldr insert Leaf . reverse

insert :: Ord a => a -> BST a -> BST a
insert x Leaf = singleton x
insert x (Branch l v r) = case compare x (head v) of
  LT -> Branch (insert x l) v r
  GT -> Branch l v (insert x r)
  EQ -> Branch l (x:v) r

singleton :: a -> BST a
singleton x = Branch Leaf [x] Leaf

toList :: BST a -> [a]
toList Leaf = []
toList (Branch l v r) = concat [toList l, v, toList r]
