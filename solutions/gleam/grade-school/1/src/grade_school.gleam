import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string
pub type School =
  Dict(Int, List(String))

pub fn create() -> School {
  dict.new()
}

pub fn roster(school: School) -> List(String) {
  dict.keys(school) |> list.sort(int.compare) |> list.flat_map(fn(grade) {
    dict.get(school, grade)
    |> result.unwrap([])
    |> list.sort(string.compare)
  })
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  case list.contains(roster(school), student) {
    True -> Error(Nil)
    False -> case dict.get(school, grade) {
      Error(Nil) -> Ok(dict.insert(school, grade, [student]))
      Ok(students) -> Ok(dict.insert(school, grade, [student, ..students]))
    }
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  result.unwrap(dict.get(school, desired_grade), [])
}
