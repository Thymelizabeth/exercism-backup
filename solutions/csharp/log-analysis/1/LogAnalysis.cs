using System;

public static class LogAnalysis 
{
    public static string SubstringAfter(this string logLine, string delimiter) => logLine.Split(delimiter, 2)[1];

    public static string SubstringBetween(this string logLine, string startChar, string endChar) {
        int start = logLine.IndexOf(startChar) + startChar.Length;
        return logLine.Substring(start, logLine.IndexOf(endChar) - start);
    }
    
    public static string Message(this string logLine) => logLine.SubstringAfter(": ");

    // TODO: define the 'LogLevel()' extension method on the `string` type
    public static string LogLevel(this string logLine) => logLine.SubstringBetween("[", "]");
}