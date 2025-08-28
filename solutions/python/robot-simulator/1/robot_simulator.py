# Globals for the directions
# Change the values as you see fit
EAST = (1, 0)
NORTH = (0, 1)
WEST = (-1, 0)
SOUTH = (0, -1)


class Robot:
    def __init__(self, direction=NORTH, x_pos=0, y_pos=0):
        self.direction = direction
        self.coordinates = (x_pos, y_pos)

    def turn_right(self):
        if self.direction == NORTH:
            self.direction = EAST
        elif self.direction == EAST:
            self.direction = SOUTH
        elif self.direction == SOUTH:
            self.direction = WEST
        elif self.direction == WEST:
            self.direction = NORTH

    def turn_left(self):
        self.turn_right()
        self.turn_right()
        self.turn_right()

    def advance(self):
        x, y = self.coordinates
        x += self.direction[0]
        y += self.direction[1]
        self.coordinates = x, y

    def move(self, instructions):
        for instruction in instructions:
            if instruction == "A":
                self.advance()
            elif instruction == "R":
                self.turn_right()
            elif instruction == "L":
                self.turn_left()

