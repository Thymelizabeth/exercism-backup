#include "lasagna_master.h"

#include <algorithm>
namespace lasagna_master {

int preparationTime(std::vector<std::string> layers, int time) {
  return time * layers.size();
}

struct amount quantities(std::vector<std::string> layers) {
  auto result = amount{};
  result.noodles = 50 * std::count(layers.begin(), layers.end(), "noodles");
  result.sauce = 0.2 * std::count(layers.begin(), layers.end(), "sauce");
  return result;
}

void addSecretIngredient(std::vector<std::string> &myList,
                         const std::vector<std::string> &friendsList) {
  addSecretIngredient(myList, friendsList.back());
}

void addSecretIngredient(std::vector<std::string> &myList,
                         const std::string &secretIngredient) {
  myList.back() = secretIngredient;
}

std::vector<double> scaleRecipe(std::vector<double> quantities, int portions) {
  auto result = std::vector<double>(quantities.size());
  std::transform(
      quantities.begin(), quantities.end(), result.begin(),
      [portions](double quantity) { return portions * quantity / 2; });
  return result;
}

} // namespace lasagna_master
