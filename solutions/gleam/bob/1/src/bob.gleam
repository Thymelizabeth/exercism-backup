import gleam/bool.{guard}
import gleam/string.{contains, is_empty, last, to_graphemes, trim, uppercase}
import gleam/list.{any}

pub fn hey(remark: String) -> String {
  let s = trim(remark)
  use <- guard(is_empty(s), "Fine. Be that way!")
  use <- guard(last(s) == Ok("?") && uppercase(s) == s && any(to_graphemes(s), is_alpha), "Calm down, I know what I'm doing!")
  use <- guard(last(s) == Ok("?"), "Sure.")
  use <- guard(uppercase(s) == s && any(to_graphemes(s), is_alpha), "Whoa, chill out!")
  "Whatever."
}

fn is_alpha(l: String) -> Bool {
  contains("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", l)
}
