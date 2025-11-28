module Satellite (treeFromTraversals) where

import BinaryTree (BinaryTree(..))
import Data.List (nub)

treeFromTraversals :: Ord a => [a] -> [a] -> Maybe (BinaryTree a)
treeFromTraversals preorder inorder =
  if preorder /= nub preorder || inorder /= nub inorder then
    Nothing
  else
    case (preorder, inorder) of
      ([], []) -> Nothing
      (_:_, []) -> Nothing
      ([], _:_) -> Nothing
      ([root], [leftmost]) -> 
        if root == leftmost then
          Just $ Branch Leaf root Leaf
        else
          Nothing
      (value : preorder, inorder) ->
        case span (\x -> x /= value) inorder of
          (leftInorder, _ : rightInorder) ->
            do
              left <- treeFromTraversals leftPreorder leftInorder
              right <- treeFromTraversals rightPreorder rightInorder
              return $ Branch left value right
            where
              (leftPreorder, rightPreorder) = splitAt (length leftInorder) preorder
          (_, []) -> Nothing
