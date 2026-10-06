#pragma once
#include <string>

namespace star_map {
enum class System {
  AlphaCentauri,
  BetaHydri,
  DeltaEridani,
  EpsilonEridani,
  Omicron2Eridani,
  Sol,
};
}

namespace heaven {
class Vessel {
public:
  Vessel(std::string captain, int generation,
         star_map::System current_system = star_map::System::Sol);
  Vessel replicate(std::string new_captain);
  void make_buster();
  bool shoot_buster();

  std::string name;
  int generation;
  star_map::System current_system;
  unsigned int busters = 0;
};

std::string get_older_bob(Vessel bob1, Vessel bob2);
bool in_the_same_system(Vessel vessel1, Vessel vessel2);
} // namespace heaven
