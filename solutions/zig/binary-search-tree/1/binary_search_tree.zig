const std = @import("std");
const mem = std.mem;

pub const Node = struct {
    data: i32,
    left: ?*Node,
    right: ?*Node,

    pub fn deinit(self: *Node, allocator: mem.Allocator) void {
        if (self.left) |left| {
            left.deinit(allocator);
        }
        if (self.right) |right| {
            right.deinit(allocator);
        }
        allocator.destroy(self);
    }

    pub fn insert(self: *Node, allocator: mem.Allocator, data: i32) mem.Allocator.Error!void {
        if (self.data >= data) {
            if (self.left) |left| {
                try left.insert(allocator, data);
            } else {
                self.left = try mem.Allocator.create(allocator, Node);
                var left = self.left.?;
                left.data = data;
                left.left = null;
                left.right = null;
            }
        } else {
            if (self.right) |right| {
                try right.insert(allocator, data);
            } else {
                self.right = try mem.Allocator.create(allocator, Node);
                var right = self.right.?;
                right.data = data;
                right.left = null;
                right.right = null;
            }
        }
    }

    pub fn sortedData(self: *Node, allocator: mem.Allocator) mem.Allocator.Error![]i32 {
        var res = try allocator.alloc(i32, 0);
        errdefer allocator.free(res);
        if (self.left) |left| {
            const l = try left.sortedData(allocator);
            allocator.free(res);
            res = l;
        }
        res = try allocator.realloc(res, res.len + 1);
        res[res.len - 1] = self.data;
        if (self.right) |right| {
            const r = try right.sortedData(allocator);
            defer allocator.free(r);
            res = try allocator.realloc(res, res.len + r.len);
            @memcpy(res[res.len - r.len .. res.len], r);
        }
        return res;
    }
};

pub const Tree = struct {
    root: ?*Node,
    allocator: mem.Allocator,

    pub fn init(allocator: mem.Allocator) Tree {
        return .{
            .root = null,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Tree) void {
        if (self.root) |root| {
            root.deinit(self.allocator);
            self.root = null;
        }
    }

    pub fn insert(self: *Tree, data: i32) mem.Allocator.Error!void {
        if (self.root) |root| {
            try root.insert(self.allocator, data);
        } else {
            self.root = try mem.Allocator.create(self.allocator, Node);
            var root = self.root.?;
            root.data = data;
            root.left = null;
            root.right = null;
        }
    }

    pub fn sortedData(self: *const Tree, allocator: mem.Allocator) mem.Allocator.Error![]i32 {
        if (self.root) |root| {
            return root.sortedData(allocator);
        } else {
            return allocator.alloc(i32, 0);
        }
    }
};
