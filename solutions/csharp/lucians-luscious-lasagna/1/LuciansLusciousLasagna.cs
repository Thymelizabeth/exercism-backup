class Lasagna
{
    public int ExpectedMinutesInOven() 
    {
        return 40;
    }

    public int RemainingMinutesInOven(int minutesInOven)
    {
        return ExpectedMinutesInOven() - minutesInOven;
    }

    public int PreparationTimeInMinutes(int layers)
    {
        const int MINUTES_PER_LAYER = 2;
        return MINUTES_PER_LAYER * layers;
    }

    public int ElapsedTimeInMinutes(int layers, int minutesInOven)
    {
        return minutesInOven + PreparationTimeInMinutes(layers);
    }
}
