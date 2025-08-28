import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(b) = problem
  b
}

pub fn remove_team_prefix(team: String) -> String {
  let assert True = string.starts_with(team, "Team ")
  let drop_length = string.length("Team ")
  string.drop_start(team, drop_length)
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert Ok(#(region, team)) = string.split_once(combined, ",")
  #(region, remove_team_prefix(team))
}
