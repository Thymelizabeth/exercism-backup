using System;

class BirdCount
{
    private int[] birdsPerDay;

    public BirdCount(int[] birdsPerDay)
    {
        this.birdsPerDay = birdsPerDay;
    }

    public static int[] LastWeek() => new int[] {0, 2, 5, 3, 7, 8, 4};

    public int Today() => birdsPerDay[birdsPerDay.Length - 1];

    public void IncrementTodaysCount() => birdsPerDay[birdsPerDay.Length - 1]++;

    public bool HasDayWithoutBirds() => Array.FindIndex(birdsPerDay, n => n==0) != -1;

    public int CountForFirstDays(int numberOfDays)
    {
        int sum = 0;
        foreach (var birds in new ArraySegment<int>(birdsPerDay, 0, numberOfDays))
        {
            sum += birds;
        }
        return sum;
    }

    public int BusyDays() => Array.FindAll(birdsPerDay, n => n >= 5).Length;
}
