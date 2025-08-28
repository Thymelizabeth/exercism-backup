public class LogLine {

    String logLine;
    
    public LogLine(String logLine) {
	this.logLine = logLine;
    }

    public LogLevel getLogLevel() {
	return switch (logLine.substring(1, 4)) {
	case "TRC" -> LogLevel.TRACE;
	case "DBG" -> LogLevel.DEBUG;
	case "INF" -> LogLevel.INFO;
	case "WRN" -> LogLevel.WARNING;
	case "ERR" -> LogLevel.ERROR;
	case "FTL" -> LogLevel.FATAL;
	case null, default -> LogLevel.UNKNOWN;
	};
    }

    public String getOutputForShortLog() {
        int prefix = switch (getLogLevel()) {
	case LogLevel.UNKNOWN -> 0;
	case LogLevel.TRACE -> 1;
	case LogLevel.DEBUG -> 2;
	case LogLevel.INFO -> 4;
	case LogLevel.WARNING -> 5;
	case LogLevel.ERROR -> 6;
	case LogLevel.FATAL -> 42;
	};
	return prefix + ":" + logLine.substring(7);
    }
}
