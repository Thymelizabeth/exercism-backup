import java.time.LocalDateTime
import java.time.LocalDate

class Gigasecond(val now: LocalDateTime) {
    constructor(now: LocalDate): this(now.atTime(0, 0))

    val date: LocalDateTime = now.plusSeconds(1_000_000_000)
}
