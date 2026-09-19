pub const Direction = enum {
    north,
    east,
    south,
    west,
};

pub const Robot = struct {
    x: i32,
    y: i32,
    direction: Direction,

    pub fn init(x: i32, y: i32, direction: Direction) Robot {
        return .{ .x = x, .y = y, .direction = direction };
    }

    pub fn move(self: *Robot, instructions: []const u8) void {
        for (instructions) |instruction| {
            switch (instruction) {
                'A' => self.advance(),
                'R' => self.turnRight(),
                'L' => self.turnLeft(),
                else => unreachable,
            }
        }
    }

    fn advance(self: *Robot) void {
        switch (self.direction) {
            .north => self.y += 1,
            .east => self.x += 1,
            .south => self.y -= 1,
            .west => self.x -= 1,
        }
    }

    fn turnRight(self: *Robot) void {
        self.direction = switch (self.direction) {
            .north => .east,
            .east => .south,
            .south => .west,
            .west => .north,
        };
    }

    fn turnLeft(self: *Robot) void {
        self.direction = switch (self.direction) {
            .north => .west,
            .west => .south,
            .south => .east,
            .east => .north,
        };
    }
};
