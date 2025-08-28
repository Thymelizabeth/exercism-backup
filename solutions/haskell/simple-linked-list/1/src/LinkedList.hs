module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = 
  Cons a (LinkedList a)
  | Nil
  deriving (Eq, Show)

instance Foldable LinkedList where
  foldr f z Nil = z
  foldr f z (Cons x xs) = x `f` foldr f z xs

datum :: LinkedList a -> a
datum (Cons a _) = a
datum Nil = error "empty linked list"

fromList :: [a] -> LinkedList a
fromList [] = Nil
fromList (x:xs) = Cons x (fromList xs)

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _   = False

new :: a -> LinkedList a -> LinkedList a
new x linkedList = Cons x linkedList

next :: LinkedList a -> LinkedList a
next (Cons _ a) = a
next Nil = error "empty linked list"

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = foldl (flip Cons) Nil 

toList :: LinkedList a -> [a]
toList Nil = []
toList (Cons x xs) = x : toList xs

appendLinkedList :: LinkedList a -> LinkedList a -> LinkedList a
appendLinkedList Nil ys = ys
appendLinkedList (Cons x xs) ys = Cons x (appendLinkedList xs ys)