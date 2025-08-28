public class CarsAssemble {

    final int BASE_HOURLY_RATE = 221;
    
    public double productionRatePerHour(int speed) {
	double successRate;
        if (speed < 5) {
	    successRate = 1;
	} else if (speed < 9) {
	    successRate = 0.9;
	} else if (speed == 9) {
	    successRate = 0.8;
	} else {
	    successRate = 0.77;
	}
	return BASE_HOURLY_RATE * successRate * speed;
    }

    public int workingItemsPerMinute(int speed) {
        return (int)Math.floor(productionRatePerHour(speed) / 60.0);
    }
}
