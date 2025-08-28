import gleam/list.{length, filter}

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  case place_location {
    #(x, y) -> #(y, x)
  }
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  treasure_location == place_location_to_treasure_location(place_location)
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  length(filter(treasures, fn(x) { treasure_location_matches_place_location(place.1, x.1) }))
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case found_treasure.0 {
    "Brass Spyglass" if place.0 == "Abandoned Lighthouse" -> True
    "Amethyst Octopus" if place.0 == "Stormy Breakwater" -> case desired_treasure.0 {
      "Crystal Crab" | "Glass Starfish" -> True
      _ -> False
    }
    "Vintage Pirate Hat" if place.0 == "Harbor Managers Office" -> case desired_treasure.0 {
      "Model Ship in Large Bottle" | "Antique Glass Fishnet Float" -> True
      _ -> False
    } 
    _ -> False
  }
}
