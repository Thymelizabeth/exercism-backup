collatz_steps(1, 0).
collatz_steps(N, Steps) :- 
    N > 0,
    next(N, M),
    collatz_steps(M, Step),
    Steps is Step + 1.

even(N) :- N mod 2 =:= 0.
next(N, M) :- even(N), M is N / 2.
next(N, M) :- M is N * 3 + 1.