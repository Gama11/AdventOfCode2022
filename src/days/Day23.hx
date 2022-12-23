package days;

import util.Direction.*;

class Day23 {
	public static function countEmptyTilesBetweenElves(input:String):Int {
		final elves = Util.parseGrid(input, s -> if (s == "#") true else null).map;
		final directions = [
			[Up, Up + Left, Up + Right],
			[Down, Down + Left, Down + Right],
			[Left, Left + Up, Left + Down],
			[Right, Right + Up, Right + Down],
		];
		for (_ in 0...10) {
			final proposals = new HashMap<Point, Array<Point>>();
			for (elf in elves.keys()) {
				if (!Direction.all.exists(dir -> elves.exists(elf + dir))) {
					continue;
				}
				for (direction in directions) {
					if (direction.foreach(dir -> !elves.exists(elf + dir))) {
						proposals.compute(elf + direction[0], v -> (v ?? []).concat([elf]));
						break;
					}
				}
			}
			for (target => origins in proposals) {
				if (origins.length == 1) {
					elves.remove(origins[0]);
					elves[target] = true;
				}
			}
			directions.push(directions.shift());
		}
		final bounds = Util.findBounds(elves.keys().array());
		var emptyTiles = 0;
		for (x in bounds.min.x...bounds.max.x + 1) {
			for (y in bounds.min.y...bounds.max.y + 1) {
				final pos = new Point(x, y);
				if (!elves.exists(pos)) {
					emptyTiles++;
				}
			}
		}
		return emptyTiles;
	}
}
