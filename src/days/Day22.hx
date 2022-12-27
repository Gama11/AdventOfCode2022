package days;

import polygonal.ds.Hashable;
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

	public static function findPassword(input:String, wrappingAlgorithm:(map:HashMap<Point, Tile>) -> WrappingAlgorithm):Int {
		final input = parse(input);
		final map = input.grid.map;
		final wrappingAlgorithm = wrappingAlgorithm(map);

		var facing = Right;
		var pos = [for (x in 0...input.grid.width) new Point(x, 0)].find(pos -> map[pos] == Empty);

		for (i in 0...input.path.length) {
			final move = input.path[i];
			switch move {
				case GoForward(amount):
					for (_ in 0...amount) {
						var newPos = pos + facing;
						var newFacing = facing;
						if (!map.exists(newPos)) {
							final wrap = wrappingAlgorithm.apply(pos, facing);
							newPos = wrap.pos;
							newFacing = wrap.facing;
						}
						switch map[newPos] {
							case Empty:
								pos = newPos;
								facing = newFacing;
							case Wall:
								break;
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

interface WrappingAlgorithm {
	function apply(pos:Point, facing:Direction):{pos:Point, facing:Direction}
}

class FlatWrappingAlgorithm implements WrappingAlgorithm {
	final map:HashMap<Point, Tile>;

	public function new(map) {
		this.map = map;
	}

	public function apply(pos:Point, facing:Direction):{pos:Point, facing:Direction} {
		while (true) {
			final wrappedPos = pos - facing;
			if (!map.exists(wrappedPos)) {
				return {pos: pos, facing: facing};
			}
			pos = wrappedPos;
		}
	}
}

class CubeWrappingAlgorithm implements WrappingAlgorithm {
	final layout:CubeLayout;
	final size:Int;
	final map:HashMap<Point, Tile>;
	final sides:HashMap<Point, {count:Int, pos:Point}>;

	public function new(size, layout, map) {
		this.layout = layout;
		this.size = size;
		this.map = map;

		sides = new HashMap();
		var count = 1;
		final indices = new HashMap<Point, Int>();
		for (pos in map.keys()) {
			final column = int(pos.x / size);
			final row = int(pos.y / size);
			final cubePos = new Point(column, row);
			sides[pos] = {
				count: indices[cubePos] ?? indices.compute(cubePos, _ -> count++),
				pos: cubePos,
			};
		}
	}

	public function apply(pos:Point, facing:Direction):{pos:Point, facing:Direction} {
		final side = sides[pos];
		final crossing = layout.get(side.count, facing);

		final nextSide = sides.find(side -> side.count == crossing.side);
		var localPos = new Point(pos.x % size, pos.y % size);

		localPos = switch facing {
			case Up: new Point(localPos.x, size - 1);
			case Down: new Point(localPos.x, 0);
			case Left: new Point(size - 1, localPos.y);
			case Right: new Point(0, localPos.y);
			case _: throw 'unreachable';
		}

		while (facing != crossing.facing) {
			facing = facing.rotate(1);
			localPos = new Point(size - 1 - localPos.y, localPos.x);
		}
		final globalPos = nextSide.pos * size + localPos;
		return {pos: globalPos, facing: crossing.facing};
	}
}

private class CubeCrossing implements Hashable {
	final face:Int;
	final direction:Direction;

	public var key(default, null):Int;

	public function new(face, direction) {
		this.face = face;
		this.direction = direction;
		key = Direction.horizontals.indexOf(direction) * 10 + face;
	}
}

@:forward(keyValueIterator)
abstract CubeLayout(HashMap<CubeCrossing, {side:Int, facing:Direction}>) {
	public static final Example = {
		final layout = new CubeLayout();
		layout.add(1, Left, 3, Down);
		layout.add(1, Up, 2, Down);
		layout.add(1, Right, 6, Left);
		layout.add(2, Left, 6, Up);
		layout.add(2, Down, 5, Up);
		layout.add(3, Down, 5, Right);
		layout.add(4, Right, 6, Down);
		layout;
	};

	public static final Input = {
		final layout = new CubeLayout();
		layout.add(1, Left, 4, Right);
		layout.add(1, Up, 6, Right);
		layout.add(2, Up, 6, Up);
		layout.add(2, Right, 5, Left);
		layout.add(2, Down, 3, Left);
		layout.add(3, Left, 4, Down);
		layout.add(5, Down, 6, Left);
		layout;
	};

	function new() {
		this = new HashMap();
	}

	function add(fromSide:Int, fromFacing:Direction, toSide:Int, toFacing:Direction) {
		this[new CubeCrossing(fromSide, fromFacing)] = {side: toSide, facing: toFacing};
		this[new CubeCrossing(toSide, toFacing.rotate(2))] = {side: fromSide, facing: fromFacing.rotate(2)};
	}

	public function get(side:Int, direction:Direction) {
		return this[new CubeCrossing(side, direction)];
	}
}
