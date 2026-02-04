colors(["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]).

value([X, Y | _], Value) :-
    colors(Colors),
    nth0(XVal, Colors, X),
    nth0(YVal, Colors, Y),
    Value is XVal * 10 + YVal.