// Take a look at the tests, you might have to change the function arguments
const order = @import("std").math.order;

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    const mid = items.len / 2;
    if (mid >= items.len) {
        return null;
    }
    return switch (order(target, items[mid])) {
            .lt => binarySearch(T, target, items[0..mid]),
            .eq => mid,
            .gt => mid + 1 + (binarySearch(T, target, items[mid+1..]) orelse return null),
    };
}
