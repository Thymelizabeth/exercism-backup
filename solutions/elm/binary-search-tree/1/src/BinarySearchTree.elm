module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Empty
    | Tree BinaryTree Int BinaryTree


makeTree : List Int -> BinaryTree
makeTree =
    List.foldl insert Empty


sort : List Int -> List Int
sort =
    makeTree >> fromTree


insert : Int -> BinaryTree -> BinaryTree
insert x tree =
    case tree of
        Empty ->
            Tree Empty x Empty

        Tree l v r ->
            case compare x v of
                GT ->
                    Tree l v (insert x r)

                _ ->
                    Tree (insert x l) v r


fromTree : BinaryTree -> List Int
fromTree tree =
    case tree of
        Empty ->
            []

        Tree l v r ->
            List.concat [ fromTree l, [ v ], fromTree r ]
