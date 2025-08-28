module [steps]

steps : U64 -> Result U64 _
steps = |number|
    when number is
        0 -> Err(0)
        1 -> Ok(0)
        n -> Ok(steps_acc(n, 0))

steps_acc : U64, U64 -> U64
steps_acc = |number, acc|
    when number is
        0 -> 0
        1 -> acc
        n if Num.is_even(n) -> steps_acc(n // 2, acc + 1)
        n -> steps_acc(3 * n + 1, acc + 1)