#include <stdbool.h>
#ifndef SCRABBLE_SCORE_H
#define SCRABBLE_SCORE_H

unsigned int score(char word[]);

unsigned int letter_score(int letter);

bool contains(int x, char xs[]);
#endif
