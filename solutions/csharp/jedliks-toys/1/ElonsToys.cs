using System;

class RemoteControlCar
{
    private int _distanceDriven = 0;
    private int _batteryRemaining = 100;
    
    public static RemoteControlCar Buy() => new RemoteControlCar();

    public string DistanceDisplay() => $"Driven {_distanceDriven} meters";

    public string BatteryDisplay() => _batteryRemaining > 0 ? $"Battery at {_batteryRemaining}%" : "Battery empty";

    public void Drive()
    {
        if (_batteryRemaining > 0)
        {
            _batteryRemaining--;
            _distanceDriven += 20;
        }
    }
}
