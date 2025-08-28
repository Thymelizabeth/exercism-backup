using System;

public static class Hamming
{
    public static int Distance(string firstStrand, string secondStrand)
    {
        if (firstStrand.Length != secondStrand.Length)
            throw new ArgumentException();
        int distance = 0;
        for (int i = 0; i < firstStrand.Length; i++)
        {
            distance += firstStrand[i] != secondStrand[i] ? 1 : 0;
        }
        return distance;
    }
}