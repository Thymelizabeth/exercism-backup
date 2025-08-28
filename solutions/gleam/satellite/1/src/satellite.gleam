import gleam/list
import gleam/result

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  case list.unique(inorder), list.unique(preorder) {
    dedup_inorder, dedup_preorder if dedup_inorder == inorder && dedup_preorder == preorder -> case inorder, preorder {
    [], [] -> Ok(Nil)
    [leftmost], [root] -> case leftmost == root {
      False -> Error(DifferentItems)
      True -> Ok(Node(value: root, left: Nil, right: Nil))
    }
    [], _ -> Error(DifferentLengths)
    _, [] -> Error(DifferentLengths)
    inorder, [value, ..preorder] -> 
      case list.split_while(inorder, fn(x) { x != value}) {
        #(left_inorder, [_, ..right_inorder]) -> {
          let #(left_preorder, right_preorder) = list.split(preorder, list.length(left_inorder))
          use left <- result.try(tree_from_traversals(left_inorder, left_preorder))
          use right <- result.try(tree_from_traversals(right_inorder, right_preorder))
          Ok(Node(value, left, right))
        }
      #(_, []) -> Error(DifferentItems)
    }
  }
_, _ -> Error(NonUniqueItems)
}
}
