using System;

static class AssemblyLine
{
    public static double SuccessRate(int speed) => speed switch 
    {
        0 => 0.0,
        < 5 => 1.0,
        < 9 => 0.9,
        9 => 0.8,
        10 => 0.77,
        _ => 0.0,
    };
    
    public static double ProductionRatePerHour(int speed) => 221.0 * speed * SuccessRate(speed);

    public static int WorkingItemsPerMinute(int speed) => (int)Math.Floor(ProductionRatePerHour(speed) / 60.0);
}
