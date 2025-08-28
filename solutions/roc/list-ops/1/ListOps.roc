module [append, concat, filter, length, map, foldl, foldr, reverse]

append : List a, List a -> List a
append = |list1, list2|
    when list2 is
        [] -> list1
        [x, .. as xs] -> append(List.append(list1, x), xs)

concat : List (List a) -> List a
concat = |lists|
    foldl(lists, [], append)

filter : List a, (a -> Bool) -> List a
filter = |list, function|
    f = |xs, acc|
        when xs is
            [] -> acc
            [first, .. as rest] ->
                if function(first) then
                    f(rest, List.append(acc, first))
                else
                    f(rest, acc)
    f(list, [])
            

length : List a -> U64
length = |list|
    len = |xs, acc|
        when xs is
            [] -> acc
            [_, .. as rest] -> len(rest, acc + 1)
    len(list, 0)

map : List a, (a -> b) -> List b
map = |list, function|
    m = |xs, acc|
        when xs is
            [] -> acc
            [first, .. as rest] -> m(rest, List.append(acc, function(first)))
    m(list, [])

foldl : List a, b, (b, a -> b) -> b
foldl = |list, initial, function|
    when list is
        [] -> initial
        [first, .. as rest] -> foldl(rest, function(initial, first), function)

foldr : List a, b, (b, a -> b) -> b
foldr = |list, initial, function|
    when list is
        [] -> initial
        [first, .. as rest] -> function(foldr(rest, initial, function), first)

reverse : List a -> List a
reverse = |list|
    when list is
        [] -> []
        [first, .. as rest] -> List.append(reverse(rest), first)
