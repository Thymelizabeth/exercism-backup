const std = @import("std");
const mem = std.mem;

pub const TraversalError = error{
    DifferentLengths,
    DifferentItems,
    NonUniqueItems,
};

pub const Node = struct {
    allocator: mem.Allocator,
    data: u8,
    left: ?*Node = null,
    right: ?*Node = null,

    fn deinit(self: *Node) void {
        if (self.left) |left| {
            left.deinit();
        }
        if (self.right) |right| {
            right.deinit();
        }
        self.allocator.destroy(self);
    }
};

pub const Tree = struct {
    root: ?*Node,

    pub fn initFromTraversals(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8) (mem.Allocator.Error || TraversalError)!Tree {
        if (!(try isUnique(allocator, preorder)) or !(try isUnique(allocator, inorder))) {
            return TraversalError.NonUniqueItems;
        }
        if (preorder.len != inorder.len) {
            return TraversalError.DifferentLengths;
        }
        if (!(try sameItems(allocator, preorder, inorder))) {
            return TraversalError.DifferentItems;
        }
        if (preorder.len == 0) {
            return Tree{ .root = null };
        }
        const root = try allocator.create(Node);
        errdefer root.deinit();
        root.data = preorder[0];
        root.allocator = allocator;
        const root_index = std.mem.findScalar(u8, inorder, root.data).?;
        const left_inorder = inorder[0..root_index];
        const right_inorder = inorder[root_index + 1 ..];
        const left_preorder = preorder[1 .. left_inorder.len + 1];
        const right_preorder = preorder[left_inorder.len + 1 ..];
        root.left = (try Tree.initFromTraversals(allocator, left_preorder, left_inorder)).root;
        root.right = (try Tree.initFromTraversals(allocator, right_preorder, right_inorder)).root;
        return Tree{ .root = root };
    }

    pub fn deinit(self: *Tree) void {
        if (self.root) |root| {
            root.deinit();
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

fn sameItems(allocator: mem.Allocator, a: []const u8, b: []const u8) mem.Allocator.Error!bool {
    const a_sorted = try allocator.dupe(u8, a);
    defer allocator.free(a_sorted);
    const b_sorted = try allocator.dupe(u8, b);
    defer allocator.free(b_sorted);
    mem.sort(u8, a_sorted, {}, std.sort.asc(u8));
    mem.sort(u8, b_sorted, {}, std.sort.asc(u8));
    return mem.eql(u8, a_sorted, b_sorted);
}
