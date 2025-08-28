object CollatzCalculator {
    fun computeStepCount(start: Int): Int =
            if (start < 1) throw IllegalArgumentException("positive integers only")
            else computeStepCountR(start, 0)

    fun computeStepCountR(n: Int, stepCount: Int): Int =
            if (n == 1) stepCount
            else if (n.mod(2) == 0) computeStepCountR(n.div(2), stepCount + 1)
            else computeStepCountR(n.times(3).plus(1), stepCount + 1)
}
