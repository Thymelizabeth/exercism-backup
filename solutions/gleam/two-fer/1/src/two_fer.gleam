import gleam/option.{type Option, unwrap}

pub fn two_fer(name: Option(String)) -> String {
  "One for " <> unwrap(name, "you") <> ", one for me."
}
