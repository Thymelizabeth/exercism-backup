#include "darts.h"
#include <cmath>

namespace darts {

int score(double x, double y) {
  double distance = std::sqrt(std::pow(x, 2) + std::pow(y, 2));
  if (distance > 10)
    return 0;
  if (distance > 5)
    return 1;
  if (distance > 1)
    return 5;
  return 10;
}

} // namespace darts
