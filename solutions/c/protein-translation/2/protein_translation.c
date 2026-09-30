#include "protein_translation.h"

protein_t protein(const char *rna) {
  protein_t result = {.valid = true, .count = 0};
  for (size_t i = 0; i < MAX_AMINO_ACIDS; i++) {
    result.count++;
    switch (rna[i * 3]) {
    case 'A':
      if (rna[i * 3 + 1] == 'U' && rna[i * 3 + 2] == 'G') {
        result.amino_acids[i] = Methionine;
      } else {
        result.valid = false;
        return result;
      }
      break;
    case 'U':
      switch (rna[i * 3 + 1]) {
      case 'A':
        switch (rna[i * 3 + 2]) {
        case 'A':
        case 'G':
          result.count--;
          return result;
          break;
        case 'C':
        case 'U':
          result.amino_acids[i] = Tyrosine;
          break;
        default:
          result.valid = false;
          return result;
          break;
        }
        break;
      case 'C':
        switch (rna[i * 3 + 2]) {
        case 'A':
        case 'C':
        case 'G':
        case 'U':
          result.amino_acids[i] = Serine;
          break;
        default:
          result.valid = false;
          return result;
          break;
        }
        break;
      case 'G':
        switch (rna[i * 3 + 2]) {
        case 'A':
          result.count--;
          return result;
          break;
        case 'G':
          result.amino_acids[i] = Tryptophan;
          break;
        case 'C':
        case 'U':
          result.amino_acids[i] = Cysteine;
          break;
        default:
          result.valid = false;
          return result;
          break;
        }
        break;
      case 'U':
        switch (rna[i * 3 + 2]) {
        case 'A':
        case 'G':
          result.amino_acids[i] = Leucine;
          break;
        case 'C':
        case 'U':
          result.amino_acids[i] = Phenylalanine;
          break;
        default:
          result.valid = false;
          return result;
          break;
        }
        break;
      default:
        result.valid = false;
        return result;
        break;
      }
      break;
    case '\0':
      result.count--;
      return result;
      break;
    default:
      result.valid = false;
      return result;
      break;
    }
  }
  return result;
}
