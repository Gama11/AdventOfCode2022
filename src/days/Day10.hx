package days;

private enum Instruction {
	Addx(value:Int);
	Noop;
}

class Day10 {
	static function parse(input:String) {
		return input.split("\n").map(function(line) {
			return switch line.split(" ") {
				case ["addx", value]: Addx(parseInt(value));
				case ["noop"]: Noop;
				case v: throw 'unexpected $v';
			}
		});
	}

	public static function sumSignalStrengths(input:String):Int {
		final instructions = parse(input);
		var x = 1;
		var cycle = 0;
		var signalStrengthSum = 0;
		final crt = new HashMap<Point, String>();
		final crtWidth = 40;
		final crtHeight = 6;

		for (instruction in instructions) {
			inline function passCycle() {
				final pixel = new Point(cycle % crtWidth, Math.floor(cycle / crtWidth));
				final spriteVisible = pixel.x == x - 1 || pixel.x == x || pixel.x == x + 1;
				crt[pixel] = if (spriteVisible) "#" else ".";
				
				cycle++;

				if ((cycle - 20) % crtWidth == 0) {
					signalStrengthSum += x * cycle;
				}
				if (cycle == crtWidth * crtHeight) {
					break;
				}
			}
			switch instruction {
				case Addx(value):
					passCycle();
					passCycle();
					x += value;
				case Noop:
					passCycle();
			}
		}
		Sys.println(Util.renderPointHash(crt, s -> s));
		return signalStrengthSum;
	}
}
