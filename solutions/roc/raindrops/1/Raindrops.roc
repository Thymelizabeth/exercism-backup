module [convert]

translation : Dict U64 Str
translation = Dict.fromList [ (3, "Pling")
                            , (5, "Plang")
                            , (7, "Plong")
                            ]

convert : U64 -> Str
convert = \number ->
    word = Dict.walk translation "" (\acc, key, value -> 
        if number % key == 0 then 
            Str.concat acc value 
        else
            acc
    )
    if Str.isEmpty word then
        Num.toStr number
    else
        word