package days;

import util.Direction.*;

class Day23 {
	static function parse(input:String) {
		return Util.parseGrid(input, s -> if (s == "#") true else null).map;
	}

	static function simulate(round:Int, elves:HashMap<Point, Bool>):Bool {
		final directions = [
			[Up, Up + Left, Up + Right],
			[Down, Down + Left, Down + Right],
			[Left, Left + Up, Left + Down],
			[Right, Right + Up, Right + Down],
		];
		for (_ in 0...round % directions.length) {
			directions.push(directions.shift());
		}

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
		
		var anyChanges = false;
		for (target => origins in proposals) {
			if (origins.length == 1) {
				elves.remove(origins[0]);
				elves[target] = true;
				anyChanges = true;
			}
		}
		return anyChanges;
	}

	public static function countEmptyTilesBetweenElves(input:String):Int {
		final elves = parse(input);
		for (round in 0...10) {
			simulate(round, elves);
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

	public static function findFirstRoundWithoutMovement(input:String):Int {
		final elves = parse(input);
		var round = 0;
		while (simulate(round++, elves)) {}
		return round;
	}
}
