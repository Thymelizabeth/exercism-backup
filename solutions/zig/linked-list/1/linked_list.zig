pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *LinkedList(T), data: *Node) void {
            data.prev = self.last;
            if (self.last) |last| {
                last.next = data;
                self.last = data;
            } else {
                self.first = data;
                self.last = data;
            }
            self.len += 1;
        }

        pub fn pop(self: *LinkedList(T)) ?*Node {
            const popped = self.last;
            self.last = if (popped) |p| p.prev else null;
            if (self.last) |last| {
                last.next = null;
            } else {
                self.first = null;
            }
            self.len -= 1;
            return popped;
        }

        pub fn shift(self: *LinkedList(T)) ?*Node {
            const shifted = self.first;
            self.first = if (shifted) |s| s.next else null;
            if (self.first) |first| {
                first.prev = null;
            } else {
                self.last = null;
            }
            self.len -= 1;
            return shifted;
        }

        pub fn unshift(self: *LinkedList(T), data: *Node) void {
            data.next = self.first;
            if (self.first) |first| {
                first.prev = data;
                self.first = data;
            } else {
                self.first = data;
                self.last = data;
            }
            self.len += 1;
        }

        pub fn delete(self: *LinkedList(T), data: *Node) void {
            var opcur = self.first;
            while (opcur) |cur| : (opcur = cur.next) {
                if (cur.data == data.data) {
                    if (self.first == cur) {
                        self.first = cur.next;
                    }
                    if (self.last == cur) {
                        self.last = cur.prev;
                    }
                    if (cur.prev) |prev| {
                        prev.next = cur.next;
                    }
                    if (cur.next) |next| {
                        next.prev = cur.prev;
                    }
                    self.len -= 1;
                    break;
                }
            }
        }
    };
}
