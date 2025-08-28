class Robot(var gridPosition: GridPosition = GridPosition(0, 0), var orientation: Orientation = Orientation.NORTH) {

    fun simulate(instructions: String) {
        instructions.forEach {instruction ->
	    when (instruction) {
		'A' -> advance()
		'L' -> turnLeft()
		'R' -> turnRight()
		else -> throw IllegalArgumentException()
	    }}
    }

    fun advance() {
	gridPosition = when (orientation) {
	    Orientation.NORTH -> gridPosition.copy(y = gridPosition.y + 1)
	    Orientation.SOUTH -> gridPosition.copy(y = gridPosition.y - 1)
	    Orientation.EAST  -> gridPosition.copy(x = gridPosition.x + 1)
	    Orientation.WEST  -> gridPosition.copy(x = gridPosition.x - 1)
	}
    }

    fun turnRight() {
	orientation = when (orientation) {
	    Orientation.NORTH -> Orientation.EAST
	    Orientation.EAST  -> Orientation.SOUTH
	    Orientation.SOUTH -> Orientation.WEST
	    Orientation.WEST  -> Orientation.NORTH
	}
    }

    fun turnLeft() {
	orientation = when (orientation) {
	    Orientation.NORTH -> Orientation.WEST
	    Orientation.WEST  -> Orientation.SOUTH
	    Orientation.SOUTH -> Orientation.EAST
	    Orientation.EAST  -> Orientation.NORTH
	}
    }
}
