package days;

class Day09 {
	static function parse(input:String):Array<Direction> {
		return input.split("\n").flatMap(function(line) {
			final parts = line.split(" ");
			final amount = parseInt(parts[1]);
			final direction = switch parts[0] {
				case "U": Direction.Up;
				case "D": Direction.Down;
				case "L": Direction.Left;
				case "R": Direction.Right;
				case _: throw "unexpected";
			};
			return [for (_ in 0...amount) direction];
		});
	}

	public static function countVisitedPositions(input:String, length:Int):Int {
		final visited = new HashMap<Point, Bool>();
		visited[new Point(0, 0)] = true;
		final rope = [for (_ in 0...length) new Point(0, 0)];

		for (direction in parse(input)) {
			rope[0] += direction;
			for (i in 1...rope.length) {
				if (!Direction.all.exists(dir -> rope[i] + dir == rope[i - 1])) {
					rope[i] += (rope[i - 1] - rope[i]).sign();
				}
			}
			visited[rope.last()] = true;
		}
		return visited.count();
	}
}
