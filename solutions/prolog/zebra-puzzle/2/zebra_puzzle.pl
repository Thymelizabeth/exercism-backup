house(Number, Owner, Colour, Pet, Beverage, Hobby) :- 
    (Owner = englishman,
    Colour = red;
    Owner = spaniard,
    Pet = dog;
    Colour = green,
    Beverage = coffee;
    Owner = ukrainian,
    Beverage = tea;
    Hobby = dancing,
    Pet = snails;
    Hobby = painting,
    Colour = yellow;
    Beverage = milk,
    Number = 3;
    Owner = norwegian,
    Number = 1;
    Beverage = orange-juice,
    Hobby = football;
    Owner = japanese,
    Hobby = chess;
    Number = 2,
    Colour = blue),
    member(Colour, [red, blue, green, yellow, ivory]),
    member(Number, [1,2,3,4,5]),
    member(Owner, [englishman, spaniard, ukrainian, norwegian, japanese]),
    member(Pet, [dog, snails, zebra, fox, horse]),
    member(Beverage, [coffee, tea, milk, orange-juice, water]),
    member(Hobby, [dancing, painting, reading, football, chess]).
house(X, _, green, _, _, _) :- 
    house(X-1, _, ivory, _, _, _),
    X >= 2,
    X =< 5.
house(X, _, _, fox, _, _) :- 
    house(X-1, _, _, _, _, reading),
    X >= 2,
    X =< 5.
house(X, _, _, fox, _, _) :-
    house(X+1, _, _, _, _, reading),
    X >= 1,
    X =< 4.
house(X, _, _, horse, _, _) :-
    house(X-1, _, _, _, _, painting),
    X >= 2,
    X =< 5.
house(X, _, _, horse, _, _) :-
    house(X+1, _, _, _, _, kools),
    X >= 1,
    X =< 4.

zebra_owner(Owner) :- house(_, Owner, _, zebra, _, _).

water_drinker(Drinker) :- house(_, Drinker, _, _, water, _).
