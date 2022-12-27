package days;

class Day12 {
	public static function findFewestSteps(input:String, startingTiles:Array<String>):Int {
		final map = Util.parseGrid(input, s -> s).map;
		var starts = [for (pos => tile in map) if (startingTiles.contains(tile)) new SearchState(pos)];

		var start = null;
		var end = null;
		for (pos => tile in map) {
			switch tile {
				case "S":
					start = pos;
				case "E":
					end = pos;
			}
		}
		map[start] = "a";
		map[end] = "z";

		return AStar.search(starts, s -> s.pos == end, s -> s.pos.distanceTo(end), function(state) {
			return Direction.horizontals //
				.map(dir -> state.pos + dir) //
				.filter(neighbor -> {
					if (!map.exists(neighbor)) {
						return false;
					}
					final elevation = map[state.pos].charCodeAt(0);
					final neighborElevation = map[neighbor].charCodeAt(0);
					return neighborElevation - elevation <= 1;
				}) //
				.map(pos -> {
					cost: 1,
					state: new SearchState(pos),
				});
		}).score;
	}
}

private class SearchState {
	public var pos:Point;

	public function new(pos) {
		this.pos = pos;
	}

	public function hashed():String {
		return pos.shortString();
	}
}
