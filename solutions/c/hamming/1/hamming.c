#include "hamming.h"

static int compute_r(const char *lhs, const char *rhs, int diff) {
  if (*lhs == '\0' && *rhs == '\0') {
    return diff;
  }
  if (*lhs == '\0' || *rhs == '\0') {
    return -1;
  }
  if (*lhs == *rhs) {
    return compute_r(lhs + 1, rhs + 1, diff);
  }
  return compute_r(lhs + 1, rhs + 1, diff + 1);
}

int compute(const char *lhs, const char *rhs) { return compute_r(lhs, rhs, 0); }
