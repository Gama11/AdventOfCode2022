package days;

import util.Direction.*;

private enum Tile {
	Rock;
	Sand;
}

class Day14 {
	static function parse(input:String):Array<Array<Point>> {
		return input.lines().map(function(line) {
			return line.split(" -> ").map(function(coord) {
				final parts = coord.split(",").map(parseInt);
				return new Point(parts[0], parts[1]);
			});
		});
	}

	public static function countRestingSand(input:String, withFloor:Bool):Int {
		final map = new HashMap<Point, Tile>();
		final scans = parse(input);
		for (scan in scans) {
			for (line in scan.windowed(2)) {
				final start = line[0];
				final end = line[1];
				final move = (end - start).sign();

				var current = start;
				do {
					map[current] = Rock;
					current += move;
				} while (current != end);
				map[end] = Rock;
			}
		}

		final maxY = Util.findBounds(map.keys().array()).max.y;
		final source = new Point(500, 0);
		while (!map.exists(source)) {
			var pos = source;
			while (true) {
				final options = [pos + Down, pos + Down + Left, pos + Down + Right];
				var resting = true;
				for (option in options) {
					final isBlocked = map.exists(option) || (withFloor && option.y == maxY + 2);
					if (!isBlocked) {
						pos = option;
						resting = false;
						break;
					}
				}
				if (resting) {
					map[pos] = Sand;
					break;
				} else if (pos.y > maxY && !withFloor) {
					return map.count(tile -> tile == Sand);
				}
			}
		}
		return map.count(tile -> tile == Sand);
	}
}
