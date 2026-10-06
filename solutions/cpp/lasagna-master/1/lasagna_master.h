#pragma once

#include <string>
#include <vector>
namespace lasagna_master {

struct amount {
  int noodles;
  double sauce;
};

int preparationTime(std::vector<std::string> layers, int time = 2);
struct amount quantities(std::vector<std::string> layers);
void addSecretIngredient(std::vector<std::string> &myList,
                         const std::vector<std::string> &friendsList);
void addSecretIngredient(std::vector<std::string> &myList,
                         const std::string &secretIngredient);
std::vector<double> scaleRecipe(std::vector<double> quantities, int portions);
} // namespace lasagna_master
