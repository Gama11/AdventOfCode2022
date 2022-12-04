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
		return parse(input).count(function(pair) {
			function contains(a:Range, b:Range):Bool {
				return a.start >= b.start && a.end <= b.end;
			}
			return contains(pair.first, pair.second) || contains(pair.second, pair.first);
		});
	}

	public static function countOverlappingPairs(input:String):Int {
		return parse(input).count(function(pair) {
			final a = pair.first;
			final b = pair.second;
			return a.end >= b.start && a.start <= b.end;
		});
	}
}
