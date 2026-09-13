#include "scrabble_score.h"
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

unsigned int score(char word[]) {
  unsigned int sum = 0;
  for (size_t i = 0; i < strlen(word); i++) {
    sum = sum + letter_score(toupper(word[i]));
  }
  return sum;
}

unsigned int letter_score(int letter) {
  char *score_1 = "AEIOULNRST";
  char *score_2 = "DG";
  char *score_3 = "BCMP";
  char *score_4 = "FHVWY";
  char *score_5 = "K";
  char *score_8 = "JX";
  char *score_10 = "QZ";

  if (contains(letter, score_1)) {
    return 1;
  } else if (contains(letter, score_2)) {
    return 2;
  } else if (contains(letter, score_3)) {
    return 3;
  } else if (contains(letter, score_4)) {
    return 4;
  } else if (contains(letter, score_5)) {
    return 5;
  } else if (contains(letter, score_8)) {
    return 8;
  } else if (contains(letter, score_10)) {
    return 10;
  } else {
    return 0;
  }
}

bool contains(int x, char xs[]) {
  for (size_t i = 0; i < strlen(xs); i++) {
    if (xs[i] == x) {
      return true;
    }
  }
  return false;
}
