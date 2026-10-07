#include "power_of_troy.h"

namespace troy {
void give_new_artifact(human &human, std::string artifact_name) {
  human.possession = std::make_unique<artifact>(artifact_name);
}

void exchange_artifacts(std::unique_ptr<artifact> &artifact1,
                        std::unique_ptr<artifact> &artifact2) {
  std::swap(artifact1, artifact2);
}

void manifest_power(human &human, std::string power_effect) {
  human.own_power = std::make_shared<power>(power_effect);
}

void use_power(const human &caster, human &target) {
  if (caster.own_power != nullptr) {
    target.influenced_by = caster.own_power;
  }
}

int power_intensity(const human &human) {
  if (human.own_power == nullptr) {
    return 0;
  }
  return human.own_power.use_count();
}
} // namespace troy
