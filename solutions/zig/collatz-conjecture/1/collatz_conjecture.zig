pub const ComputationError = error {
    IllegalArgument,
};

pub fn steps(number: usize) anyerror!usize {
    return switch (number) {
      0 => ComputationError.IllegalArgument,
      1 => 0,
      else => steps_acc(number, 0),
    };
}

fn steps_acc(n: usize, acc: usize) usize {
    return switch (n) {
      0 => 0,
      1 => acc,
      else => if (n % 2 == 0)
                steps_acc(n / 2, acc + 1)
              else 
                steps_acc(3 * n + 1, acc + 1),
    };
}