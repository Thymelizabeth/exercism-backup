class NeedForSpeed {
    int speed;
    int batteryDrainRate;
    int batteryCharge = 100;
    int distanceDriven = 0;
    
    NeedForSpeed(int speed, int batteryDrain) {
        this.speed = speed;
	this.batteryDrainRate = batteryDrain;
    }

    public boolean batteryDrained() {
        return batteryCharge < batteryDrainRate;
    }

    public int distanceDriven() {
        return distanceDriven;
    }

    public void drive() {
        if (!batteryDrained()) {
	    distanceDriven += speed;
	}
	batteryCharge = Math.max(0, batteryCharge - batteryDrainRate);
    }

    public static NeedForSpeed nitro() {
	return new NeedForSpeed(50, 4);
    }
}

class RaceTrack {

    int distance;
    
    RaceTrack(int distance) {
	this.distance = distance;
    }

    public boolean canFinishRace(NeedForSpeed car) {
        return (double)distance / car.speed * car.batteryDrainRate <= 100.0;
    }
}
