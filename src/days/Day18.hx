package days;

import haxe.ds.ReadOnlyArray;

class Day18 {
	static function parse(input:String):HashMap<PointN, Bool> {
		final list = input.lines().map(line -> new PointN(line.splitToInt(",")));
		final map = new HashMap<PointN, Bool>();
		for (cube in list) {
			map[cube] = true;
		}
		return map;
	}

	static final directions:ReadOnlyArray<PointN> = [
		new PointN([1, 0, 0]),
		new PointN([0, 1, 0]),
		new PointN([0, 0, 1]),
		new PointN([-1, 0, 0]),
		new PointN([0, -1, 0]),
		new PointN([0, 0, -1]),
	];

	public static function calculateSurfaceArea(input:String):Int {
		final lava = parse(input);
		var coveredSides = 0;
		for (cube in lava.keys()) {
			for (direction in directions) {
				if (lava.exists(cube + direction)) {
					coveredSides++;
				}
			}
		}
		return lava.count() * 6 - coveredSides;
	}

	public static function calculateExteriorSurfaceArea(input:String):Int {
		final lava = parse(input);
		final dimensions = [0, 1, 2];
		final min = lava.keys().next().coordinates.copy();
		final max = min.copy();
		for (cube in lava.keys()) {
			for (dimension in dimensions) {
				min[dimension] = int(Math.min(cube[dimension], min[dimension]));
				max[dimension] = int(Math.max(cube[dimension], max[dimension]));
			}
		}
		final min = new PointN(min) - new PointN([1, 1, 1]);
		final max = new PointN(max) + new PointN([1, 1, 1]);

		final water = new HashMap<PointN, Bool>();
		final newWater = new HashMap<PointN, Bool>();
		newWater[min] = true;

		while (newWater.size > 0) {
			final pos = newWater.keys().next();
			newWater.remove(pos);
			water[pos] = true;
			for (dir in directions) {
				final neighbor = pos + dir;
				if (!newWater.exists(neighbor)
					&& !water.exists(neighbor)
					&& !lava.exists(neighbor)
					&& dimensions.foreach(i -> pos[i] >= min[i] && pos[i] <= max[i])) {
					newWater[neighbor] = true;
				}
			}
		}

		final sidesTouchingWater = lava.keys()
			.array()
			.map(pos -> directions.count(dir -> water.exists(pos + dir)))
			.sum();
		return sidesTouchingWater;
	}
}
