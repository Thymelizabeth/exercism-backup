import gleam/int.{compare}
import gleam/list.{fold, concat}
import gleam/order.{Lt, Eq, Gt}

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  fold(data, Nil, insert)
}

fn to_list(data: Tree) -> List(Int) {
  case data {
    Nil -> []
    Node(v, l, r) -> concat([to_list(l), [v], to_list(r)])
  }
}

fn insert(tree: Tree, x: Int) -> Tree {
  case tree {
    Nil -> Node(x, Nil, Nil)
    Node(v, l, r) -> case compare(x, v) {
      Lt | Eq -> Node(v, insert(l, x), r)
      Gt -> Node(v, l, insert(r, x))
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> to_tree
  |> to_list
}
