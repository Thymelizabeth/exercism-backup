module [twoFer]

twoFer : [Name Str, Anonymous] -> Str
twoFer = \name ->
    person = when name is
        Anonymous -> "you"
        Name s -> s
    "One for $(person), one for me."
