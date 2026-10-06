#include "doctor_data.h"

namespace heaven {

Vessel::Vessel(std::string captain, int generation,
               star_map::System current_system)
    : name(captain), generation(generation), current_system(current_system) {}
Vessel Vessel::replicate(std::string new_captain) {
  return {new_captain, generation + 1, current_system};
}
void Vessel::make_buster() { busters++; }
bool Vessel::shoot_buster() {
  if (busters > 0) {
    busters--;
    return true;
  }
  return false;
}

std::string get_older_bob(Vessel bob1, Vessel bob2) {
  if (bob1.name == "Bob" || bob2.name == "Bob") {
    return "Bob";
  }
  return "";
}

bool in_the_same_system(Vessel vessel1, Vessel vessel2) {
  return vessel1.current_system == vessel2.current_system;
}

} // namespace heaven
