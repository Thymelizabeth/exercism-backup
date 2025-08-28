import gleam/string.{length}

pub opaque type TreasureChest(treasure) {
  TreasureChest(password: String, treasure: treasure)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case password |> length() {
    n if n < 8 -> Error("Password must be at least 8 characters long")
    _ -> Ok(TreasureChest(password: password, treasure: contents))
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  let TreasureChest(chest_password, treasure) = chest
  case chest_password == password {
    True -> Ok(treasure)
    False -> Error("Incorrect password")
  }
}
