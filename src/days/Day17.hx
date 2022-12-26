package days;

import util.Direction.*;

class Day17 {
	public static function determineTowerHeight(input:String):Int {
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
			}
			wallHeight += increase;
		}
		buildWall(10);

		var floor = 0;
		var jetIndex = 0;
		for (i in 0...2022) {
			final rock = rocks[i % rocks.length];
			var pos = new Point(2, floor + 4);

			while (true) {
				function tryMove(dir:Direction):Bool {
					return if (rock.map.keys().iterable().exists(offset -> chamber.exists(pos + offset + dir))) {
						false;
					} else {
						pos += dir;
						true;
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
				}
			}
		}
		return floor;
	}
}
