using System;

class RemoteControlCar
{
    private int speed;
    private int batteryDrain;
    private int batteryCharge;
    private int distanceDriven;
    
    public RemoteControlCar(int speed, int batteryDrain)
    {
        this.speed = speed;
        this.batteryDrain = batteryDrain;
        this.batteryCharge = 100;
        this.distanceDriven = 0;
    }

    public bool BatteryDrained() => batteryCharge < batteryDrain;

    public int DistanceDriven() => distanceDriven;

    public void Drive()
    {
        if (!BatteryDrained())
        {
            distanceDriven += speed;
            batteryCharge -= batteryDrain;
        }
    }

    public static RemoteControlCar Nitro() => new RemoteControlCar(50, 4);
}

class RaceTrack
{
    private int distance;

    public RaceTrack(int distance) => this.distance = distance;

    public bool TryFinishTrack(RemoteControlCar car)
    {
        while (car.DistanceDriven() < distance)
        {
            if (car.BatteryDrained())
                return false;
            car.Drive();
        }
        return true;
    }
}
