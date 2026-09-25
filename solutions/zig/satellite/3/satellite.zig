const std = @import("std");
const mem = std.mem;

pub const TraversalError = error{
    DifferentLengths,
    DifferentItems,
    NonUniqueItems,
};

pub const Node = struct {
    data: u8,
    left: ?*Node = null,
    right: ?*Node = null,

    pub fn initFromTraversals(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8) (mem.Allocator.Error || TraversalError)!?*Node {
        if (preorder.len != inorder.len) {
            return TraversalError.DifferentLengths;
        }
        if (preorder.len == 0) {
            return null;
        }
        const root_index = std.mem.findScalar(u8, inorder, preorder[0]) orelse return TraversalError.DifferentItems;
        const left_inorder = inorder[0..root_index];
        const right_inorder = inorder[root_index + 1 ..];
        const left_preorder = preorder[1 .. left_inorder.len + 1];
        const right_preorder = preorder[left_inorder.len + 1 ..];
        const root = try allocator.create(Node);
        errdefer root.deinit(allocator);
        root.data = preorder[0];
        root.left = try Node.initFromTraversals(allocator, left_preorder, left_inorder);
        root.right = try Node.initFromTraversals(allocator, right_preorder, right_inorder);
        return root;
    }

    fn deinit(self: *Node, allocator: mem.Allocator) void {
        if (self.left) |left| {
            left.deinit(allocator);
        }
        if (self.right) |right| {
            right.deinit(allocator);
        }
        allocator.destroy(self);
    }
};

pub const Tree = struct {
    allocator: mem.Allocator,
    root: ?*Node,

    pub fn initFromTraversals(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8) (mem.Allocator.Error || TraversalError)!Tree {
        if (!(try isUnique(allocator, preorder)) or !(try isUnique(allocator, inorder))) {
            return TraversalError.NonUniqueItems;
        }
        if (preorder.len != inorder.len) {
            return TraversalError.DifferentLengths;
        }
        const root = try Node.initFromTraversals(allocator, preorder, inorder);
        return Tree{ .root = root, .allocator = allocator };
    }

    pub fn deinit(self: *Tree) void {
        if (self.root) |root| {
            root.deinit(self.allocator);
        }
    }
};

fn isUnique(allocator: mem.Allocator, data: []const u8) mem.Allocator.Error!bool {
    const sorted_data = try allocator.dupe(u8, data);
    defer allocator.free(sorted_data);
    mem.sort(
        u8,
        sorted_data,
        {},
        std.sort.asc(u8),
    );
    var last_item = if (sorted_data.len > 0) sorted_data[0] else return true;
    for (sorted_data[1..]) |item| {
        if (item == last_item)
            return false;
        last_item = item;
    }
    return true;
}
