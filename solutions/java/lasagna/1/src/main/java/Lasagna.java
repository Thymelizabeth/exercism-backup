public class Lasagna {
    private final int EXPECTED_MINUTES_IN_OVEN = 40;
    private final int MINUTES_OF_PREPARATION_PER_LAYER = 2;
    
    public int expectedMinutesInOven() {
	return EXPECTED_MINUTES_IN_OVEN;
    }

    public int remainingMinutesInOven(int minutesInOven) {
	return expectedMinutesInOven() - minutesInOven;
    }

    public int preparationTimeInMinutes(int layers) {
	return layers * MINUTES_OF_PREPARATION_PER_LAYER;
    }

    public int totalTimeInMinutes(int layers, int minutesInOven) {
	return minutesInOven + preparationTimeInMinutes(layers);
    }
}
