pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  case first {
    [] -> second
    [x, ..rest] -> [x, ..append(rest, second)]
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  case lists {
    [] -> []
    [x] -> x
    [x, y, ..rest] -> concat([append(x, y), ..rest])
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  case list {
    [] -> []
    [x, ..rest] -> case function(x) {
      True -> [x, ..filter(rest, function)]
      False -> filter(rest, function)
    }
  }
}

pub fn length(list: List(a)) -> Int {
  case list {
    [] -> 0
    [_, ..rest] -> 1 + length(rest)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [x, ..rest] -> [function(x), ..map(rest, function)]
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [x, ..rest] -> foldl(rest, function(initial, x), function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [x, ..rest] -> function(foldr(rest, initial, function), x)
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  case list {
    [] -> []
    [x, ..rest] -> append(reverse(rest), [x])
  }
}
