package days;

private typedef AssignmentPair = {
	final first:Range;
	final second:Range;
}

private typedef Range = {
	final start:Int;
	final end:Int;
}

class Day04 {
	static function parse(input:String):Array<AssignmentPair> {
		return input.split("\n").map(function(line) {
			final regex = ~/(\d+)-(\d+),(\d+)-(\d+)/;
			regex.match(line);
			return {
				first: {
					start: regex.int(1),
					end: regex.int(2),
				},
				second: {
					start: regex.int(3),
					end: regex.int(4),
				}
			}
		});
	}

	public static function countFullyContainedPairs(input:String):Int {
		function contains(a:Range, b:Range):Bool {
			return a.start >= b.start && a.end <= b.end;
		}
		return parse(input).count(function(pair) {
			return contains(pair.first, pair.second) || contains(pair.second, pair.first);
		});
	}
}
