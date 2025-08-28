module [from_list, to_list]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

from_list : List U64 -> BinaryTree
from_list = |data|
    data |> List.walk(Nil, insert)

to_list : BinaryTree -> List U64
to_list = |tree|
    when tree is
        Nil -> []
        Node { value, left, right } -> List.join([to_list(left), [value], to_list(right)]) 

insert : BinaryTree, U64 -> BinaryTree
insert = |tree, to_insert|
    when tree is
        Nil -> Node { value: to_insert, left: Nil, right: Nil }
        Node {value, left, right} -> 
            when Num.compare(value, to_insert) is
                GT | EQ -> Node {value, left: insert(left, to_insert), right}
                LT -> Node {value, left, right: insert(right, to_insert)}