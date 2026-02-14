open Base

type bst = Leaf | Node of {value : int; left : bst; right : bst}

let empty = Leaf

let value = function
  | Leaf -> Error "empty tree"
  | Node {value; _} -> Ok value

let left = function
  | Leaf -> Error "no"
  | Node {left; _} -> Ok left

let right = function
  | Leaf -> Error "no"
  | Node {right; _} -> Ok right

let rec insert x = function
  | Leaf -> Node {value = x; left = Leaf; right = Leaf}
  | Node {value; left; right} when x <= value -> Node {value; left = insert x left; right}
  | Node {value; left; right} when x > value -> Node {value; left; right = insert x right}

let rec to_list = function
  | Leaf -> []
  | Node {value; left; right} -> to_list left @ [value] @ to_list right

