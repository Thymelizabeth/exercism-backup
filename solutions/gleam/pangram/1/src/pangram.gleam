import gleam/set.{size, intersection, from_list}
import gleam/string.{lowercase, to_graphemes}

pub fn is_pangram(sentence: String) -> Bool {
  26 == size(intersection(from_list(to_graphemes(lowercase(sentence))), from_list(to_graphemes("abcdefghijklmnopqrstuvwxyz"))))
}
