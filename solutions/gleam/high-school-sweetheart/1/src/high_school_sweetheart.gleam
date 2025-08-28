import gleam/string.{trim_left, capitalise, first, split, join}
import gleam/result.{unwrap}
import gleam/list.{map}

pub fn first_letter(name: String) {
  name
  |> trim_left()
  |> first()
  |> unwrap("")
}

pub fn initial(name: String) {
  name
  |> first_letter()
  |> capitalise() <> "."
}

pub fn initials(full_name: String) {
  full_name
  |> split(on: " ")
  |> map(initial)
  |> join(with: " ")
}

pub fn pair(full_name1: String, full_name2: String) {
  //      ******       ******
  //    **      **   **      **
  //  **         ** **         **
  // **            *            **
  // **                         **
  // **     X. X.  +  X. X.     **
  //  **                       **
  //    **                   **
  //      **               **
  //        **           **
  //          **       **
  //            **   **
  //              ***
  //               *
  "\n     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     " <> initials(full_name1) <> "  +  " <> initials(full_name2) <> "     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
}
