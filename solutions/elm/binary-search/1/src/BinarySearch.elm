module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Maybe Int
find target unordered_xs =
    let
        sorted_xs =
            if sorted unordered_xs then
                unordered_xs

            else
                unordered_xs |> Array.toList |> List.sort |> Array.fromList

        find_ start end xs =
            let
                middle =
                    (end + start) // 2
            in
            if start > end then
                Nothing
            else
                Array.get middle xs
                    |> Maybe.andThen
                        (\x ->
                            case compare x target of
                                LT ->
                                    find_ (middle + 1) end xs

                                EQ ->
                                    Just middle

                                GT ->
                                    find_ start (middle - 1) xs
                        )
    in
    find_ 0 (Array.length sorted_xs) sorted_xs


sorted : Array comparable -> Bool
sorted xs =
    case Array.get 0 xs of
        Nothing ->
            True

        Just x ->
            xs
                |> Array.slice 1 (Array.length xs)
                |> Array.foldr (\a ( b, isSorted ) -> ( a, isSorted && a <= b )) ( x, True )
                |> Tuple.second
