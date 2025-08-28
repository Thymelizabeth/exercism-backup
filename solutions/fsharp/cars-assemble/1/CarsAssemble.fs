module CarsAssemble

let PRODUCTION_PER_SPEED: int = 221
let MINUTES_IN_HOUR: int = 60

let successRate (speed: int): float =
    match speed with
    | 0 -> 0.0
    | n when n >= 1 && n <= 4 -> 1.0
    | n when n >= 5 && n <= 8 -> 0.9
    | 9 -> 0.8
    | 10 -> 0.77
    | _ -> failwith "Speed should be between 0 and 10"

let productionRatePerHour (speed: int): float =
    successRate speed * float speed * float PRODUCTION_PER_SPEED

let workingItemsPerMinute (speed: int): int =
    int (productionRatePerHour speed) / MINUTES_IN_HOUR
