# this is a stub function that takes a natural_number
# and should return the difference-of-squares as described
# in the README.md
difference_of_squares <- function(n) {
  sumOfSquares <- n * (2 * n + 1) * (n + 1) / 6
  squareOfSums <- (n * (n + 1) / 2) ^ 2
  max(sumOfSquares, squareOfSums) - min(sumOfSquares, squareOfSums)
}