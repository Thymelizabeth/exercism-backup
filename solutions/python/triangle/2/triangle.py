def equilateral(sides):
    return all(map(lambda x: x == sides[0] and x > 0, sides))


def isosceles(sides):
    return all(map((lambda x: x > 0), sides)) and (sides[0] == sides[1] or sides[0] == sides[2] or sides[1] == sides[2]) and sides[0] + sides[1] >= sides[2] and sides[1] + sides[2] >= sides[0] and sides[0] + sides[2] >= sides[1]


def scalene(sides):
    return all(map((lambda x: x > 0), sides)) and sides[0] != sides[1] and sides[1] != sides[2] and sides[0] != sides[2] and sides[0] + sides[1] >= sides[2] and sides[1] + sides[2] >= sides[0] and sides[0] + sides[2] >= sides[1]
