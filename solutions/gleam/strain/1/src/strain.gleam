import gleam/list.{reverse}

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_acc(list, predicate, [])
}

fn keep_acc(list: List(t), predicate: fn(t) -> Bool, acc: List(t)) -> List(t) {
  case list {
    [] -> reverse(acc)
    [x, ..rest] -> case predicate(x) {
      True -> keep_acc(rest, predicate, [x, ..acc])
      False -> keep_acc(rest, predicate, acc)
    }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  discard_acc(list, predicate, [])
}

fn discard_acc(list: List(t), predicate: fn(t) -> Bool, acc: List(t)) -> List(t) {
  case list {
    [] -> reverse(acc)
    [x, ..rest] -> case predicate(x) {
      False -> discard_acc(rest, predicate, [x, ..acc])
      True -> discard_acc(rest, predicate, acc)
    }
  }
}