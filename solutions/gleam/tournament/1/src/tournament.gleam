import gleam/dict.{type Dict, new, upsert, values}
import gleam/int
import gleam/list.{fold, reverse, sort}
import gleam/option.{None, Some}
import gleam/string.{join, pad_left, pad_right, split}

type Team {
  Team( name: String
      , played: Int
      , wins: Int
      , losses: Int
      , draws: Int
      , points: Int
      )
}

pub fn tally(input: String) -> String {
  input
  |> split(on: "\n")
  |> fold(new(), fn(acc: Dict(String, Team), game: String) -> Dict(String, Team) {
    case split(game, ";") {
      [team1, team2, result] -> case result {
        "win" -> add_win(acc, team1, team2)
        "loss" -> add_win(acc, team2, team1)
        "draw" -> add_draw(acc, team1) |> add_draw(team2)
        _ -> acc
      }
      _ -> acc
    }
  })
  |> values()
  |> export()
}

fn add_win(acc: Dict(String, Team), winner: String, loser: String) {
  acc 
  |> upsert(winner, fn(team) {
    case team {
      None -> Team(name: winner, wins: 1, losses: 0, draws: 0, played: 1, points: 3)
      Some(t) -> Team(..t, wins: t.wins + 1, played: t.played + 1, points: t.points + 3)
    }
  })
  |> upsert(loser, fn(team) {
    case team {
      None -> Team(name: loser, wins: 0, losses: 1, draws: 0, played: 1, points: 0)
      Some(t) -> Team(..t, losses: t.losses + 1, played: t.played + 1)
    }
  })
}

fn add_draw(acc: Dict(String, Team), drawer: String) -> Dict(String, Team) {
  acc
  |> upsert(drawer, fn(team) {
    case team {
      None -> Team(name: drawer, wins: 0, losses: 0, draws: 1, played: 1, points: 1)
      Some(t) -> Team(..t, draws: t.draws + 1, played: t.played + 1, points: t.points + 1)
    }
  })
}

fn export(input: List(Team)) -> String {
  input
  |> sort(fn(t1, t2) { string.compare(t1.name, t2.name) })
  |> sort(fn(t1, t2) { int.compare(t2.points, t1.points) })
  |> fold(["Team                           | MP |  W |  D |  L |  P"], fn(acc, team) {
    [to_string(team), ..acc]
  })
  |> reverse()
  |> join("\n")
}

fn to_string(team: Team) -> String {
  pad_right(team.name, 31, " ") <> "|" <>
  pad_left(int.to_string(team.played), 3, " ") <> " |" <>
  pad_left(int.to_string(team.wins), 3, " ") <> " |" <>
  pad_left(int.to_string(team.draws), 3, " ") <> " |" <>
  pad_left(int.to_string(team.losses), 3, " ") <> " |" <>
  pad_left(int.to_string(team.points), 3, " ")
}