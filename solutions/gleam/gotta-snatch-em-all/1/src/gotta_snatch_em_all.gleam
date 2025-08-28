import gleam/string.{starts_with}
import gleam/set.{type Set}
import gleam/list

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  #(
    set.contains(collection, my_card) && !set.contains(collection, their_card), 
    collection |> set.delete(my_card)|> set.insert(their_card)
  )
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [] -> []
    [x, ..rest] -> set.to_list(list.fold(rest, x, set.intersection))
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  set.size(list.fold(collections, set.new(), set.union))
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, fn(x) { starts_with(x, "Shiny ")})
}
