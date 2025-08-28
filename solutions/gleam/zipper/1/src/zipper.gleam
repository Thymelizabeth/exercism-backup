import gleam/list
import gleam/result

pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(root: Tree(a), focus: List(Direction))
}

type Direction {
  Left
  Right
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(root: tree, focus: [])
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  let Zipper(root, ..) = zipper
  root
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  let Zipper(root, focus) = zipper
  tree_value(root, focus)
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(_, []) -> Error(Nil)
    Zipper(_, focus) ->
      Ok(Zipper(..zipper, focus: list.take(focus, list.length(focus) - 1)))
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case follow_tree(zipper.root, zipper.focus) {
    Ok(Leaf) | Error(Nil) -> Error(Nil)
    _ -> Ok(Zipper(..zipper, focus: list.append(zipper.focus, [Left])))
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case follow_tree(zipper.root, zipper.focus) {
    Ok(Leaf) | Error(Nil) -> Error(Nil)
    _ -> Ok(Zipper(..zipper, focus: list.append(zipper.focus, [Right])))
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  let Zipper(root, focus) = zipper
  Zipper(set_val(root, focus, value), focus)
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  let Zipper(root, focus) = zipper
  result.map(set_l(root, focus, tree), fn(new_root) { Zipper(new_root, focus) })
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  let Zipper(root, focus) = zipper
  result.map(set_r(root, focus, tree), fn(new_root) { Zipper(new_root, focus) })
}

fn tree_value(tree: Tree(a), focus: List(Direction)) -> Result(a, Nil) {
  case follow_tree(tree, focus) {
    Ok(Node(value, ..)) -> Ok(value)
    _ -> Error(Nil)
  }
}

fn follow_tree(tree: Tree(a), focus: List(Direction)) -> Result(Tree(a), Nil) {
  case tree, focus {
    node, [] -> Ok(node)
    Node(left: left, ..), [Left, ..rest] -> follow_tree(left, rest)
    Node(right: right, ..), [Right, ..rest] -> follow_tree(right, rest)
    _, _ -> Error(Nil)
  }
}

fn set_val(tree: Tree(a), focus: List(Direction), value: a) -> Tree(a) {
  case tree, focus {
    Leaf, [] -> Node(value, Leaf, Leaf)
    Node(_, left: left, right: right), [] ->
      Node(value, left: left, right: right)
    Node(value: this_value, left: left, right: right), [Left, ..rest] ->
      Node(value: this_value, left: set_val(left, rest, value), right: right)
    Node(value: this_value, left: left, right: right), [Right, ..rest] ->
      Node(value: this_value, left: left, right: set_val(right, rest, value))
    _, _ -> panic as "Focus should always be valid"
  }
}

fn set_l(
  tree: Tree(a),
  focus: List(Direction),
  value: Tree(a),
) -> Result(Tree(a), Nil) {
  case tree, focus {
    Node(value: this_value, left: _, right: right), [] ->
      Ok(Node(value: this_value, left: value, right: right))
    Node(value: this_value, left: left, right: right), [Left, ..rest] ->
      result.map(set_l(left, rest, value), fn(new_left) {
        Node(value: this_value, left: new_left, right: right)
      })
    Node(value: this_value, left: left, right: right), [Right, ..rest] ->
      result.map(set_l(right, rest, value), fn(new_right) {
        Node(value: this_value, left: left, right: new_right)
      })
    _, _ -> Error(Nil)
  }
}

fn set_r(
  tree: Tree(a),
  focus: List(Direction),
  value: Tree(a),
) -> Result(Tree(a), Nil) {
  case tree, focus {
    Node(value: this_value, left: left, right: _), [] ->
      Ok(Node(value: this_value, left: left, right: value))
    Node(value: this_value, left: left, right: right), [Left, ..rest] ->
      result.map(set_r(left, rest, value), fn(new_left) {
        Node(value: this_value, left: new_left, right: right)
      })
    Node(value: this_value, left: left, right: right), [Right, ..rest] ->
      result.map(set_r(right, rest, value), fn(new_right) {
        Node(value: this_value, left: left, right: new_right)
      })
    _, _ -> Error(Nil)
  }
}
