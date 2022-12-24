package days;

import haxe.ds.ReadOnlyArray;
import util.Direction.*;

private enum Tile {
	Wall;
	Empty;
	Blizzard(directions:ReadOnlyArray<Direction>);
}

class Day24 {
	static function parse(input:String):Grid<Tile> {
		return Util.parseGrid(input, function(s) {
			return switch s {
				case "#": Wall;
				case ".": Empty;
				case "^": Blizzard([Up]);
				case "v": Blizzard([Down]);
				case ">": Blizzard([Right]);
				case "<": Blizzard([Left]);
				case _: throw 'unknown tile $s';
			}
		});
	}

	public static function findQuickestPath(input:String):Int {
		final grid = parse(input);
		final start = new Point(1, 0);
		final goal = new Point(grid.width - 2, grid.height - 1);

		final maps = [0 => grid.map];
		function mapAt(minute:Int):HashMap<Point, Tile> {
			return maps[minute] ?? maps.compute(minute, function(_) {
				final previous = mapAt(minute - 1);
				final newMap = new HashMap<Point, Tile>();
				for (pos => tile in previous) {
					newMap[pos] = switch tile {
						case Wall: Wall;
						case Empty | Blizzard(_): Empty;
					}
				}

				for (pos => tile in previous) {
					switch tile {
						case Blizzard(directions):
							for (dir in directions) {
								function wrap(n:Int, max:Int):Int {
									final wallWidth:Int = 1;
									return mod(n - wallWidth, max - wallWidth * 2) + wallWidth;
								}
								final x = wrap(pos.x + dir.x, grid.width);
								final y = wrap(pos.y + dir.y, grid.height);
								final newPos = new Point(x, y);
								final newTile = switch newMap[newPos] {
									case Wall: throw 'invalid blizzard move';
									case Empty: Blizzard([dir]);
									case Blizzard(directions): Blizzard(directions.concat([dir]));
								}
								newMap[newPos] = newTile;
							}
						case _:
					}
				}
				return newMap;
			});
		}

		final moves = Direction.horizontals.concat([Direction.None]);
		function neighbors(state:SearchState):Array<SearchState> {
			final newTime = state.minute + 1;
			final map = mapAt(newTime);
			return moves //
				.filter(dir -> map[state.pos + dir] == Empty) //
				.map(dir -> new SearchState(state.pos + dir, newTime));
		}
		return AStar.search( //
			[new SearchState(start, 0)], //
			s -> s.pos == goal, //
			s -> s.pos.distanceTo(goal), //
			s -> neighbors(s).map(neighbor -> {
				cost: 1,
				state: neighbor,
			})).state.minute;
	}
}

private class SearchState {
	public final pos:Point;
	public final minute:Int;

	final hash:String;

	public function new(pos, minute) {
		this.pos = pos;
		this.minute = minute;
		hash = pos.toString() + "|" + minute;
	}

	public function hashed() {
		return hash;
	}
}
