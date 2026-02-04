custom_length([], 0).
custom_length([_|T], Length) :- 
    custom_length(T, TLength),
    Length is TLength + 1.

custom_append([], Ys, Ys).
custom_append([X|Xs], Ys, [X|Zs]) :- custom_append(Xs, Ys, Zs).

custom_concat([], []).
custom_concat([Xs|Xss], Zss) :- 
    custom_concat(Xss, Yss),
    custom_append(Xs, Yss, Zss).

custom_reverse([], []).
custom_reverse([X|Xs], Ys) :- 
    custom_reverse(Xs, RXs),
    custom_append(RXs, [X], Ys).

custom_map(_, [], []).
custom_map(F, [X|Xs], [Fx|FXs]) :- call(F, X, Fx), custom_map(F, Xs, FXs).

custom_filter(_, [], []).
custom_filter(P, [X|Xs], [X|Ys]) :- call(P, X), custom_filter(P, Xs, Ys).
custom_filter(P, [_|Xs], Ys) :- custom_filter(P, Xs, Ys).

custom_foldl(_, Z, [], Z).
custom_foldl(F, Z, [X|Xs], Folded) :-
    call(F, Z, X, Acc),
    custom_foldl(F, Acc, Xs, Folded).

custom_foldr(_, [], Z, Z).
custom_foldr(F, [X|Xs], Z, Folded) :-
    custom_foldr(F, Xs, Z, Acc),
    call(F, X, Acc, Folded).