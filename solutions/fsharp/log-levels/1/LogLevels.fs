module LogLevels

let message(logLine: string): string =
    logLine
    |> _.Split(": ", 2)
    |> Array.last
    |> _.Trim()

let logLevel(logLine: string): string =
    let level = logLine.Split(": ", 2)[0]
    level.Substring(1, String.length level - 2).ToLower()

let reformat(logLine: string): string = sprintf "%s (%s)" (message logLine) (logLevel logLine)
