class Lasagna
{
    const int MINUTES_PER_LAYER = 2;
    
    public int ExpectedMinutesInOven() => 40;

    public int RemainingMinutesInOven(int minutesInOven) => ExpectedMinutesInOven() - minutesInOven;

    public int PreparationTimeInMinutes(int layers) => MINUTES_PER_LAYER * layers;

    public int ElapsedTimeInMinutes(int layers, int minutesInOven) => minutesInOven + PreparationTimeInMinutes(layers);
}
