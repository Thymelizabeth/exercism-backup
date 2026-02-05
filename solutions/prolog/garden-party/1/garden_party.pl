beverage(Chef, Beverage) :- chef(Chef, _, Beverage).

dish(Chef, Dish) :- chef(Chef, Dish, _).

chef(Chef, Dish, Beverage) :- 
    chef(Chef),
    dish(Dish),
    beverage(Beverage),
    (Chef = aisha,
    Dish = tagine;
    Chef = emma,
    Beverage = amasi;
    Dish = frybread,
    Beverage = tonic;
    Chef = mei,
    Beverage = lassi;
    Chef = winona,
    dif(Dish, pad_thai);
    Beverage = lassi,
    dif(Dish, biryani)).

chef(aisha).
chef(emma).
chef(mei).
chef(winona).

dish(pad_thai).
dish(frybread).
dish(tagine).
dish(biryani).

beverage(tonic).
beverage(lassi).
beverage(kombucha).
beverage(amasi).