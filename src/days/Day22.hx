package days;

import util.Direction.*;

private enum Tile {
	Empty;
	Wall;
}

private enum Move {
	GoForward(amount:Int);
	TurnLeft;
	TurnRight;
}

class Day22 {
	static function parse(input:String) {
		final parts = input.split("\n\n");
		final grid = Util.parseGrid(parts[0], tile -> switch tile {
			case ".": Empty;
			case "#": Wall;
			case " ": null;
			case _: throw 'invalid tile';
		});
		final path = [];
		var acc = "";
		final chars = parts[1].split("");
		for (i in 0...chars.length) {
			final char = chars[i];
			switch char {
				case "L":
					path.push(TurnLeft);
				case "R":
					path.push(TurnRight);
				case _:
					acc += char;
					if (parseInt(chars[i + 1]) == null) {
						path.push(GoForward(parseInt(acc)));
						acc = "";
					}
			}
		}
		return {grid: grid, path: path};
	}

	public static function findPassword(input:String):Int {
		final input = parse(input);
		final map = input.grid.map;
		var facing = Right;
		var pos = [for (x in 0...input.grid.width) new Point(x, 0)].find(pos -> map[pos] == Empty);
		for (i in 0...input.path.length) {
			final move = input.path[i];
			switch move {
				case GoForward(amount):
					for (_ in 0...amount) {
						var newPos = pos + facing;
						if (!map.exists(newPos)) {
							final initial = newPos;
							while (true) {
								final wrappedPos = newPos - facing;
								if (!map.exists(wrappedPos)) {
									break;
								}
								newPos = wrappedPos;
							}
						}
						switch map[newPos] {
							case Empty: pos = newPos;
							case Wall: break;
						}
					}
				case TurnLeft:
					facing = facing.rotate(-1);
				case TurnRight:
					facing = facing.rotate(1);
			}
		}
		return (1000 * (pos.y + 1)) + (4 * (pos.x + 1)) + switch facing {
			case Right: 0;
			case Down: 1;
			case Left: 2;
			case Up: 3;
			case _: throw 'invalid facing';
		}
	}
}
