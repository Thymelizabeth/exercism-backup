module [steps, stepsAcc]

steps : U64 -> Result U64 _
steps = \number ->
    when number is
        0 -> Err 0
        1 -> Ok 0
        n -> Ok (stepsAcc n 0)

stepsAcc : U64, U64 -> U64
stepsAcc = \number, acc ->
    when number is
        0 -> 0
        1 -> acc
        n if Num.isEven n -> stepsAcc (n // 2) (acc + 1)
        n -> stepsAcc (3 * n + 1) (acc + 1)
