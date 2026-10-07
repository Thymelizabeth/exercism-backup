#include "binary_search.h"

#include <stdexcept>

namespace binary_search {

std::size_t find(std::vector<int> list, int item) {
  if (list.empty()) {
    throw new std::domain_error("value not in array");
  }
  std::size_t mid = list.size() / 2;
  int mid_elem = list[mid];
  if (item < mid_elem) {
    auto temp = std::vector<int>(list.begin(), list.begin() + mid);
    return find(temp, item);
  } else if (item == mid_elem) {
    return mid;
  } else {
    auto temp = std::vector<int>(list.begin() + mid + 1, list.end());
    return mid + 1 + find(temp, item);
  }
}

} // namespace binary_search
