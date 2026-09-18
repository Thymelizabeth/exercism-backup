const std = @import("std");
const mem = std.mem;

pub const Box = union(enum) {
    none,
    one: i12,
    many: []const Box,
};

pub fn flatten(allocator: mem.Allocator, box: Box) mem.Allocator.Error![]i12 {
    return switch (box) {
        Box.none => allocator.alloc(i12, 0),
        Box.one => |i| allocator.dupe(i12, &.{i}),
        Box.many => |many| {
            var res = try allocator.alloc(i12, 0);
            errdefer allocator.free(res);

            for (many) |inner| {
                const next = try flatten(allocator, inner);
                defer allocator.free(next);
                res = try allocator.realloc(res, res.len + next.len);
                @memcpy(res[res.len - next.len .. res.len], next);
            }
            return res;
        },
    };
}
