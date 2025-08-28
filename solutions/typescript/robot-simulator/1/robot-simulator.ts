export class InvalidInputError extends Error {
  constructor(message: string) {
    super()
    this.message = message || 'Invalid Input'
  }
}

type Direction = 'north' | 'east' | 'south' | 'west';
type Coordinates = [number, number];

export class Robot {

  direction: Direction;
  coords: Coordinates;
  x: number;
  y: number;
  
  constructor() {
    this.direction = 'north';
    this.x = 0;
    this.y = 0;
    this.coords = [this.x, this.y];
  }
  
  get bearing(): Direction {
    return this.direction;
  }

  get coordinates(): Coordinates {
    this.coords = [this.x, this.y];
    return this.coords;
  }

  place(directions: { x: number; y: number; direction: string }) {
    this.x = directions.x;
    this.y = directions.y;
    switch (directions.direction) {
      case "north":
        this.direction = 'north';
        break;
      case "east":
        this.direction = 'east';
        break;
      case "south":
        this.direction = 'south';
        break;
      case "west":
        this.direction = 'west';
        break;
      default:
        throw new InvalidInputError("Invalid direction: " + directions.direction);
    }
  }

  advance() {
    switch (this.bearing) {
      case "north":
        this.y += 1;
        break;
      case "east":
        this.x += 1;
        break;
      case "south":
        this.y -= 1;
        break;
      case "west":
       this.x -= 1;
       break;
    }
  }

  turn_left() {
    switch (this.bearing) {
      case "north":
        this.direction = "west";
        break;
      case "west":
        this.direction = "south";
        break;
      case "south":
        this.direction = "east";
        break;
      case "east":
        this.direction = "north";
        break;
    }
  }

  evaluate(instructions: string) {
    for (let instruction of instructions) {
      switch (instruction) {
        case "A":
          this.advance();
          break;
        case "R":
          this.turn_left();
          this.turn_left();
        case "L":
          this.turn_left();
          break;
      }
    }
  }
}
