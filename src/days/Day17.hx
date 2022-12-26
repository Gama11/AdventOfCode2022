package days;

import util.Direction.*;

class Day17 {
	public static function determineTowerHeight(input:String, totalRocks:Int64):Int64 {
		final jets = input.split("").map(s -> switch s {
			case "<": Left;
			case ">": Right;
			case _: throw 'invalid jet $s';
		});

		final rocks = "
####

.#.
###
.#.

###
..#
..#

#
#
#
#

##
##
".trim()

			.remove("\r")
			.split("\n\n")
			.map(rock -> Util.parseGrid(rock, s -> if (s == "#") true else null));

		final chamberWidth = 7;
		final chamber = new HashMap<Point, String>();
		for (x in 0...chamberWidth) {
			chamber[new Point(x, 0)] = "-";
		}

		var wallHeight = 0;
		function buildWall(increase:Int) {
			for (y in wallHeight...wallHeight + increase) {
				chamber[new Point(-1, y)] = "|";
				chamber[new Point(chamberWidth, y)] = "|";
				for (x in -1...chamberWidth + 1) {
					chamber.remove(new Point(x, y - 50));
				}
			}
			wallHeight += increase;
		}
		buildWall(10);

		final cycles = new Map<String, {rockIndex:Int64, floor:Int}>();

		var floor = 0;
		var jetIndex = 0;
		var rockIndex:Int64 = 0;
		var skippedFloors:Int64 = 0; 
		while (rockIndex < totalRocks) {
			final rock = rocks[(rockIndex % rocks.length).low];
			var pos = new Point(2, floor + 4);
			var downMoves = 0;

			while (true) {
				function tryMove(dir:Direction):Bool {
					return if (rock.map.keys().iterable().exists(offset -> chamber.exists(pos + offset + dir))) {
						false;
					} else {
						pos += dir;
						true;
					}
				}

				if (skippedFloors == 0 && jetIndex % jets.length == 0) {
					final key = rocks.indexOf(rock) + "," + downMoves;
					if (cycles.exists(key)) {
						final rocksLeft = totalRocks - rockIndex;
						final rockSkip = rockIndex - cycles[key].rockIndex;
						final floorIncrease = floor - cycles[key].floor;
						final skips = rocksLeft / rockSkip;
						rockIndex += skips * rockSkip;
						skippedFloors = skips * floorIncrease;
					} else {
						cycles[key] = {floor: floor, rockIndex: rockIndex};
					}
				}
				tryMove(jets[jetIndex++ % jets.length]);

				final stopped = !tryMove(Up);
				if (stopped) {
					final newFloor = pos.y + rock.height - 1;
					if (newFloor > floor) {
						buildWall(int(abs(newFloor) - abs(floor)));
						floor = newFloor;
					}
					for (offset in rock.map.keys()) {
						chamber[pos + offset] = "#";
					}
					break;
				} else {
					downMoves++;
				}
			}
			rockIndex++;
		}
		return floor + skippedFloors;
	}
}
