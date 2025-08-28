
class BirdWatcher {
    private final int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
    }

    public int[] getLastWeek() {
        return new int[] { 0, 2, 5, 3, 7, 8, 4 };
    }

    public int getToday() {
        return birdsPerDay[birdsPerDay.length - 1];
    }

    public void incrementTodaysCount() {
        birdsPerDay[birdsPerDay.length - 1]++;
    }

    public boolean hasDayWithoutBirds() {
        for (int numBirds : birdsPerDay) {
	    if (numBirds == 0)
		return true;
	}
	return false;
    }

    public int getCountForFirstDays(int numberOfDays) {
	int sum = 0;
        for (int i = 0; i < Math.min(numberOfDays, birdsPerDay.length); i++) {
	    sum += birdsPerDay[i];
	}
	return sum;
    }

    public int getBusyDays() {
        int numBusyDays = 0;
	for (int numBirds : birdsPerDay) {
	    if (numBirds >= 5)
		numBusyDays++;
	}
	return numBusyDays;
    }
}
