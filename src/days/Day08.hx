package days;

class Day08 {
	static function lookAround(grid:HashMap<Point, Int>, pos:Point, dir:Direction):{viewingDistance:Int, reachedEdge:Bool} {
		final height = grid[pos];
		pos += dir;
		var viewingDistance = 0;
		while (grid.exists(pos)) {
			viewingDistance++;
			if (grid[pos] >= height) {
				return {
					viewingDistance: viewingDistance,
					reachedEdge: false,
				}
			}
			pos += dir;
		}
		return {
			viewingDistance: viewingDistance,
			reachedEdge: true,
		}
	}

	public static function countVisibleTrees(input:String):Int {
		final grid = Util.parseGrid(input, parseInt).map;
		return grid.keys().iterable().count(pos -> Direction.horizontals.exists(dir -> lookAround(grid, pos, dir).reachedEdge));
	}

	public static function findHighestScenicScore(input:String):Int {
		final grid = Util.parseGrid(input, parseInt).map;
		return grid.keys()
			.array()
			.max(pos -> Direction.horizontals.map(dir -> lookAround(grid, pos, dir).viewingDistance).product())
			.value;
	}
}
