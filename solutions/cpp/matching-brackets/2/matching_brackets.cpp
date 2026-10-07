#include "matching_brackets.h"
#include <vector>

namespace matching_brackets {

static char reciprocal(char c) {
  switch (c) {
  case ']':
    return '[';
  case '}':
    return '{';
  case ')':
    return '(';
  default:
    __builtin_unreachable();
  }
}

bool check(std::string text) {
  std::vector<char> stack{};
  for (auto c : text) {
    switch (c) {
    case '[':
    case '{':
    case '(':
      stack.push_back(c);
      break;
    case ']':
    case '}':
    case ')':
      if (stack.empty() || stack.back() != reciprocal(c))
        return false;
      stack.pop_back();
      break;
    }
  }
  return stack.empty();
}

} // namespace matching_brackets
