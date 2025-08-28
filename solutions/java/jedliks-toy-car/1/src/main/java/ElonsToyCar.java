public class ElonsToyCar {
    int batteryCharge = 100;
    int metresDriven = 0;
    
    public static ElonsToyCar buy() {
        return new ElonsToyCar();
    }

    public String distanceDisplay() {
        return "Driven " + metresDriven + " meters";
    }

    public String batteryDisplay() {
	if (batteryCharge > 0) {
	    return "Battery at " + batteryCharge + "%";   
	}
	return "Battery empty";
    }

    public void drive() {
	if (batteryCharge > 0)
	    metresDriven += 20;
	batteryCharge = Math.max(0, batteryCharge - 1);
    }
}
