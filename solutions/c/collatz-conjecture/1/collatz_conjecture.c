#include "collatz_conjecture.h"

static int steps_acc(int n, int acc)
{
    if (n == 1)
        return acc;
    else if (n % 2 == 0)
        return steps_acc(n / 2, acc + 1);
    else
        return steps_acc(n * 3 + 1, acc + 1);
}

int steps(int start)
{
    if (start <= 0)
        return ERROR_VALUE;
    else
        return steps_acc(start, 0);
}