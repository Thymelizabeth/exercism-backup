string_reverse(S, Reverse) :-
    string_chars(S, SList),
    reverse(SList, RList),
    string_chars(Reverse, RList).
