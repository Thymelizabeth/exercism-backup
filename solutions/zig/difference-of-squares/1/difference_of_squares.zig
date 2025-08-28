pub fn squareOfSum(number: usize) usize {
    var sum: usize = 0;
    for (1..number + 1) |i| {
        sum += i;
    }
    return sum * sum;
}

pub fn sumOfSquares(number: usize) usize {
    var sum: usize = 0;
    for (1..number + 1) |i| {
        sum += i * i;
    }
    return sum;
}

pub fn differenceOfSquares(number: usize) usize {
    const sumSquares = sumOfSquares(number);
    const squareSum = squareOfSum(number);
    return @truncate(@abs(@as(i128, sumSquares) - squareSum));
}
