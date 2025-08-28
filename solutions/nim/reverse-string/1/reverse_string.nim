proc reverse*(s: string): string =
  if s == "":
    return ""
  else:
    return s[^1] & reverse(s[0 ..< ^1])
