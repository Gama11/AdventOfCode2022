package days;

private typedef Measurement = {
	final sensor:Point;
	final beacon:Point;
}

class Day15 {
	static function parse(input:String):Array<Measurement> {
		return input.split("\n").map(function(line) {
			final regex = ~/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/;
			if (!regex.match(line)) {
				throw "unexpected input";
			}
			return {
				sensor: new Point(regex.int(1), regex.int(2)),
				beacon: new Point(regex.int(3), regex.int(4)),
			}
		});
	}

	public static function countExcludedPositionsInRow(input:String, row:Int):Int {
		final measurements = parse(input);
		final lines = parse(input) //
			.mapNotNull(function(measurement) {
				final sensor = measurement.sensor;
				final beacon = measurement.beacon;
				final beaconDistance = sensor.distanceTo(beacon);
				final rowDistance = int(abs(sensor.y - row));
				if (rowDistance > beaconDistance) {
					return null;
				}
				final size = beaconDistance - rowDistance;
				return {
					start: new Point(sensor.x - size, row),
					end: new Point(sensor.x + size, row),
				};
			}).sorted(function(a, b) {
				return if (a.start.x == b.start.x) {
					a.end.x - b.end.x;
				} else {
					a.start.x - b.start.x;
				}
			});

		final merged = [];
		var current = null;
		for (line in lines) {
			if (current == null) {
				current = line;
				continue;
			}
			if (current.end.x < line.start.x) {
				merged.push(current);
				current = null;
			} else if (line.end.x > current.end.x) {
				current.end = line.end;
			}
		}
		if (current != null) {
			merged.push(current);
		}

		final combinedLineWidths = merged.map(line -> line.end.x - line.start.x + 1).sum();
		final beaconsInRow = measurements //
			.map(m -> m.beacon) //
			.filter(b -> b.y == row) //
			.filterDuplicates((a, b) -> a == b) //
			.length;
			
		return combinedLineWidths - beaconsInRow;
	}
}
