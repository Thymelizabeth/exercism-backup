using System;

enum LogLevel
{
    Trace,
    Debug,
    Info,
    Warning,
    Error,
    Fatal,
    Unknown
}
    

static class LogLine
{
    public static LogLevel ParseLogLevel(string logLine) => logLine.Split("]: ", 2)[0].Substring(1) switch
        {
	    "TRC" => LogLevel.Trace,
	    "DBG" => LogLevel.Debug,
	    "INF" => LogLevel.Info,
	    "WRN" => LogLevel.Warning,
	    "ERR" => LogLevel.Error,
	    "FTL" => LogLevel.Fatal,
	    _ => LogLevel.Unknown,
        };

    public static string OutputForShortLog(LogLevel logLevel, string message) => LogLevelToNum(logLevel) + ":" + message;

    public static int LogLevelToNum(LogLevel logLevel) => logLevel switch
    {
        LogLevel.Trace => 1,
        LogLevel.Debug => 2,
        LogLevel.Info => 4,
        LogLevel.Warning => 5,
        LogLevel.Error => 6,
        LogLevel.Fatal => 42,
	_ => 0,
    };
}
