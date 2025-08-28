public class LogLevels {
    
    public static String message(String logLine) {
        return logLine.stripTrailing().replaceFirst("\\[.*\\]: ", "").stripLeading();
    }

    public static String logLevel(String logLine) {
        return logLine.replaceFirst("\\[(.*)\\]: .*", "$1").toLowerCase();
    }

    public static String reformat(String logLine) {
        return message(logLine) + " (" + logLevel(logLine).strip() + ")";
    }
}
