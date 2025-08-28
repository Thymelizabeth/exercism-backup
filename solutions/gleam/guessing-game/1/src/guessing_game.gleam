pub fn reply(guess: Int) -> String {
  let correct_guess = 42
  let min_guess = 1
  let max_guess = 100
  case guess {
    i if i < min_guess || i > max_guess -> ""
    i if i == correct_guess -> "Correct"
    i if {i == correct_guess - 1} || {i == correct_guess + 1} -> "So close"
    i if i < correct_guess -> "Too low"
    _ -> "Too high"
  }
}
