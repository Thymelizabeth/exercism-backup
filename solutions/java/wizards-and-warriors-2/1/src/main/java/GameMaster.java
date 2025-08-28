public class GameMaster {

    public String describe(Character character) {
	return "You're a level " + character.getLevel() + " " + character.getCharacterClass() + " with " + character.getHitPoints() + " hit points.";
    }

    public String describe(Destination destination) {
	return "You've arrived at " + destination.getName() + ", which has " + destination.getInhabitants() + " inhabitants.";
    }

    public String describe(TravelMethod travelMethod) {
	return "You're traveling to your destination " +  switch (travelMethod) {
	case TravelMethod.WALKING -> "by walking.";
	case TravelMethod.HORSEBACK -> "on horseback.";
	};
    }

    public String describe(Character character, Destination destination, TravelMethod travelMethod) {
	return describe(character) + " " + describe(travelMethod) + " " + describe(destination);
    }

    public String describe(Character character, Destination destination) {
	return describe(character, destination, TravelMethod.WALKING);
    }
}
