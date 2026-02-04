square(SquareNumber, Value) :-
    between(1, 64, SquareNumber),
    Value is 2 ** (SquareNumber - 1).

total(Value) :- 
    findall(X, between(1, 64, X), Squares),
    maplist(square, Squares, SquareValues),
    sum_list(SquareValues, Value).
