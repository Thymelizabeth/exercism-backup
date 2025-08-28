using System;

class WeighingMachine
{
    private double weight;

    public WeighingMachine(int precision)
    {
        Precision = precision;
    }

    public int Precision
    {
        get;
    }

    public double Weight
    {
        get { return weight; }
        set
        {
            weight = value < 0 ?
        throw new ArgumentOutOfRangeException("Cannot have negative weight")
        : value;
        }
    }

    public string DisplayWeight
    {
        get { return String.Format($"{{0:F{Precision}}} kg", Math.Round(Weight - TareAdjustment, Precision)); }
    }

    public double TareAdjustment
    {
        get;
        set;
    } = 5.0;
}
