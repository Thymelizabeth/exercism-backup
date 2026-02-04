hamming_distance(S1, S2, Dist) :-
    string_codes(S1, Xs),
    string_codes(S2, Ys),
    hamming_distance_list(Xs, Ys, Dist).

hamming_distance_list([], [], 0).
hamming_distance_list(_, [], _) :- fail.
hamming_distance_list([], _, _) :- fail.
hamming_distance_list([X|Xs], [Y|Ys], Dist) :-
    ( X = Y
    -> hamming_distance_list(Xs, Ys, Dist)
    ;  hamming_distance_list(Xs, Ys, D),
       Dist is D + 1
    ).