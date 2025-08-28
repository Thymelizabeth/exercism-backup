import gleam/result.{try}

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case game |> rule2 |> rule1 |> try(rule3) |> try(rule4) {
    Error(e) -> Game(..game, error: e)
    Ok(g) -> change_player(g)
  }
}

fn change_player(game: Game) -> Game {
  Game(..game, player: case game.player {
    Black -> White
    White -> Black
  })
}
