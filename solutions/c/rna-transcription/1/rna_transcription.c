#define _POSIX_C_SOURCE 1
#include "rna_transcription.h"
#include <string.h>

char *to_rna(const char *dna) {
  char *rna = strdup(dna);
  for (char *c = rna; *c; c++) {
    if (*c == 'A') {
      *c = 'U';
    } else if (*c == 'C') {
      *c = 'G';
    } else if (*c == 'G') {
      *c = 'C';
    } else if (*c == 'T') {
      *c = 'A';
    }
  }
  return rna;
}
