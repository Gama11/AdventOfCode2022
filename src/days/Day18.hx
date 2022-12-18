package days;

class Day18 {
	static function parse(input:String):Array<PointN> {
		return input.split("\n").map(line -> new PointN(line.splitToInt(",")));
	}

	public static function calculateSurfaceArea(input:String):Int {
		final cubes = new HashMap<PointN, Bool>();
		for (cube in parse(input)) {
			cubes[cube] = true;
		}
		var directions = [
			new PointN([1, 0, 0]),
			new PointN([0, 1, 0]),
			new PointN([0, 0, 1]),
			new PointN([-1, 0, 0]),
			new PointN([0, -1, 0]),
			new PointN([0, 0, -1]),
		];
		var coveredSides = 0;
		for (cube in cubes.keys()) {
			for (direction in directions) {
				if (cubes.exists(cube + direction)) {
					coveredSides++;
				}
			}
		}
		return cubes.count() * 6 - coveredSides;
	}
}
