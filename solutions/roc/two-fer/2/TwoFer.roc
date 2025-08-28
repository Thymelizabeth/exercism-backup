module [two_fer]

two_fer : [Name Str, Anonymous] -> Str
two_fer = |name|
    person = when name is
        Anonymous -> "you"
        Name s -> s
    "One for ${person}, one for me."
