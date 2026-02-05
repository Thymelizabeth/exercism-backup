label([X, Y, Z | _], Label) :- 
    colors(Colors),
    nth0(XVal, Colors, X),
    nth0(YVal, Colors, Y),
    nth0(ZVal, Colors, Z),
    (YVal =:= 0
    ->  Val is XVal,
        PrefixIndex is (ZVal + 1) div 3,
        Zeros is (ZVal + 1) mod 3
    ;   Val is XVal * 10 + YVal,
        PrefixIndex is ZVal div 3,
        Zeros is ZVal mod 3
    ),
    Value is Val * (10 ** Zeros),
    nth0(PrefixIndex, ["", "kilo", "mega", "giga"], Prefix),
    format(string(Label), '~d ~wohms', [Value, Prefix]).

colors(["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]).