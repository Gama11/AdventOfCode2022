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

		for (instruction in instructions) {
			inline function passCycle() {
				cycle++;
				if ((cycle - 20) % 40 == 0) {
					signalStrengthSum += x * cycle;
				}
				if (cycle == 220) {
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
		return signalStrengthSum;
	}
}
