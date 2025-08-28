pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_acc(pizza, 0)
}

fn pizza_price_acc(pizza: Pizza, acc: Int) -> Int {
  case pizza {
    Margherita -> 7 + acc
    Caprese -> 9 + acc
    Formaggio -> 10 + acc
    ExtraSauce(p) -> pizza_price_acc(p, acc + 1)
    ExtraToppings(p) -> pizza_price_acc(p, acc + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    []     -> 0
    [_]    -> order_price_acc(order, 3)
    [_, _] -> order_price_acc(order, 2)
    _      -> order_price_acc(order, 0)
  }
}

fn order_price_acc(order: List(Pizza), acc: Int) -> Int {
  case order {
    [] -> acc
    [p, ..rest] -> order_price_acc(rest, acc + pizza_price(p))
  }
}
