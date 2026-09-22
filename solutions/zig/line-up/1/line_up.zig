const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const suffix = if (number % 10 == 1 and number % 100 != 11)
        "st"
    else if (number % 10 == 2 and number % 100 != 12)
        "nd"
    else if (number % 10 == 3 and number % 100 != 13)
        "rd"
    else
        "th";
    return std.fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{ name, number, suffix });
}
