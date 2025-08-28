module [find]

find : List U64, U64 -> Result U64 [NotFound]
find = |array, value|
    when array is
        [] -> Err NotFound
        [v] -> if v == value then Ok 0 else Err NotFound
        _ ->
            mid_point = List.len(array) // 2
            when Result.map_ok(List.get(array, mid_point), |mid_value| Num.compare(mid_value, value)) is
                Ok GT -> find(List.take_first(array, mid_point), value)
                Ok EQ -> Ok mid_point
                Ok LT -> Result.map_ok(find(List.drop_first(array, mid_point), value), |found_point| found_point + mid_point)
                Err OutOfBounds -> Err NotFound
