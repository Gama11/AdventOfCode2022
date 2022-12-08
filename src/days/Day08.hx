package days;

class Day08 {
	public static function countVisibleTrees(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt).map;
		
		function isNotObstructed(pos:Point, dir:Direction) {
			final height = grid[pos];
			pos += dir;
			while (grid.exists(pos)) {
				if (grid[pos] >= height) {
					return false;
				}
				pos += dir;
			}
			return true;
		}
		return grid.keys().iterable().count(pos -> Direction.horizontals.exists(dir -> isNotObstructed(pos, dir)));
	}
}
