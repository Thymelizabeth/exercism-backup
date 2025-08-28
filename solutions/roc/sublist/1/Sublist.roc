module [sublist]

sublist : List U8, List U8 -> [Equal, Sublist, Superlist, Unequal]
sublist = |list1, list2|
    when (list1, list2) is
        ([], []) -> Equal
        (_, []) -> Superlist
        ([], _) -> Sublist
        _ -> if list1 == list2 then
            Equal
        else if list1 |> windows(List.len(list2)) |> List.any(|list| list == list2) then
            Superlist
        else if list2 |> windows(List.len(list1)) |> List.any(|list| list == list1) then
            Sublist
        else
            Unequal

windows : List *, U64 -> List List *
windows = |list, len|
    if List.len(list) >= len then
        List.range({ start: At 0, end: At (List.len(list) - len)})
        |> List.walk(
            [],
            |acc, start|
                List.append(acc, List.sublist(list, {start, len}))
        )
    else
        []