pub const DnaError = error {
    EmptyDnaStrands,
    UnequalDnaStrands,
};

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len == 0 or second.len == 0)
        return DnaError.EmptyDnaStrands;
    if (first.len != second.len)
        return DnaError.UnequalDnaStrands;
    var result: usize = 0;
    for (first, second) |s1, s2| {
        if (s1 != s2) {
            result += 1;
        }
    }
    return result;
}
