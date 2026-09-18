const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var res = std.AutoHashMap(u8, i5).init(allocator);
    errdefer res.clearAndFree();
    var iter = legacy.iterator();
    while (iter.next()) |entry| {
        for (entry.value_ptr.*) |v| {
            try res.putNoClobber(std.ascii.toLower(v), entry.key_ptr.*);
        }
    }
    return res;
}
