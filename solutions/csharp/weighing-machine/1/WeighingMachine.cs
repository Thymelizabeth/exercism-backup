using System;

class WeighingMachine
{
    private int precision;
    private double weight;
    private double tareAdjustment;

    public WeighingMachine(int precision)
    {
        this.precision = precision;
        tareAdjustment = 5.0;
    }

    public int Precision
    {
        get { return precision; }
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
        get { return String.Format(String.Format("{{0:F{0}}} kg", Precision), Weight - TareAdjustment); }
    }

    public double TareAdjustment
    {
        get { return tareAdjustment; }
        set { tareAdjustment = value; }
    }
}
