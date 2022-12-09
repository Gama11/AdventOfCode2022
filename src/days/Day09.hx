package days;

class Day09 {
	static function parse(input:String):Array<Direction> {
		return input.split("\n").flatMap(function(line) {
			final parts = line.split(" ");
			final amount = Std.parseInt(parts[1]);
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

	public static function countVisitedPositions(input:String):Int {
		final visited = new HashMap<Point, Bool>();
		visited[new Point(0, 0)] = true;

		var head = new Point(0, 0);
		var tail = new Point(0, 0);

		for (direction in parse(input)) {
			head += direction;
			if (!Direction.all.exists(dir -> tail + dir == head)) {
				final diff = head - tail;
				tail += new Point(diff.x.sign(), diff.y.sign());
				visited[tail] = true;
			}
		}
		return visited.count();
	}
}
