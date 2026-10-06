#include "reverse_string.h"
using namespace std;
#include <string>

namespace reverse_string {
string reverse_string(string s) {
  string result;
  std::copy(s.crbegin(), s.crend(), std::back_inserter(result));
  return result;
}
} // namespace reverse_string
