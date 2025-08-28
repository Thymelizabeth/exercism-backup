using System;

static class LogLine
{
    public static string Message(string logLine) => logLine.Split("]: ", 2)[1].Trim();

    public static string LogLevel(string logLine) => logLine.Split(":")[0].Trim().Trim(new char[] { '[', ']'}).ToLower();

    public static string Reformat(string logLine) => $"{Message(logLine)} ({LogLevel(logLine)})";
}
