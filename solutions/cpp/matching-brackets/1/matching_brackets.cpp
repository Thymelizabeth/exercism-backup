#include "matching_brackets.h"
#include <vector>

namespace matching_brackets {

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
      if (stack.empty() || stack.back() != '[')
        return false;
      stack.pop_back();
      break;
    case '}':
      if (stack.empty() || stack.back() != '{')
        return false;
      stack.pop_back();
      break;
    case ')':
      if (stack.empty() || stack.back() != '(')
        return false;
      stack.pop_back();
      break;
    }
  }
  return stack.empty();
}

} // namespace matching_brackets
