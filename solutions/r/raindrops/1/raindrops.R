raindrops <- function(number) {
  result <- ""
  if (number %% 3 == 0) {
    x1 <- "Pling"
  } else {
    x1 <- ""
  }
  if (number %% 5 == 0) {
    x2 <- "Plang"
  } else {
    x2 <- ""
  }
  if (number %% 7 == 0) {
    x3 <- "Plong"
  } else {
    x3 <- ""
  }
  result <- paste(x1, x2, x3, sep="")
  if (result == "") {
    return (as.character(number))
  } else {
    return (result)
  }
}
