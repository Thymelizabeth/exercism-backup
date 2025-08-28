class CollatzCalculator {

    int computeStepCount(int start) {
        if (start < 1) {
            throw new IllegalArgumentException("Only positive integers are allowed");
        }
        return computeStepCountR(start, 0);
    }

    private int computeStepCountR(int n, int stepCount) {
        if (n == 1) {
            return stepCount;
        } else if (n % 2 == 0) {
            return computeStepCountR(n / 2, stepCount + 1);
        } else {
            return computeStepCountR(n * 3 + 1, stepCount + 1);
        }
    }

}
