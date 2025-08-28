import gleam/string.{lowercase, trim}
import gleam/regex.{from_string, replace}

pub fn message(log_line: String) -> String {
  let assert Ok(re) = from_string("^\\[\\w+\\]: ")
  trim(replace(re, trim(log_line), ""))
}

pub fn log_level(log_line: String) -> String {
  let assert Ok(re) = from_string("^\\[(\\w+)\\]: .*")
  lowercase(trim(replace(re, trim(log_line), "\\1")))
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
