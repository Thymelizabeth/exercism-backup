import gleam/list.{fold, take_while}
import gleam/result.{nil_error, try}
import gleam/string.{split}
import simplifile.{read, create_file, append}

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  path
  |> read()
  |> result.map(fn(emails) { split(emails, "\n") |> take_while(fn(email) { email != "" }) })
  |> nil_error()
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path
  |> create_file()
  |> nil_error()
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  path
  |> append(email <> "\n")
  |> nil_error()
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  try(create_log_file(log_path), fn(_) {
    try(read_emails(emails_path), fn(emails) {
      list.map(emails, fn(email) {
        case send_email(email) {
          Error(Nil) -> Ok(Nil)
          Ok(Nil) -> log_sent_email(log_path, email)
        }
      })
      |> fold(Ok(Nil), fn(acc, send_result) {
        try(acc, fn(_) {send_result})
      })
    })
  })
}
