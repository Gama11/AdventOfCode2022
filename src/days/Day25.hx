package days;

class Day25 {
	static function weightAt(i:Int):Int64 {
		return Int64.fromFloat(pow(5, i));
	}

	static function snafuToDecimal(number:String):Int64 {
		var decimal:Int64 = 0;
		final digits = number.split("").reversed();
		for (i in 0...digits.length) {
			decimal += weightAt(i) * switch digits[i] {
				case "-": -1;
				case "=": -2;
				case "2", "1", "0": parseInt(digits[i]);
				case _: throw 'invalid digit';
			}
		}
		return decimal;
	}

	static function decimalToSnafu(number:Int64):String {
		function abs(n:Int64):Int64 {
			return if (n < 0) n * -1 else n;
		}

		var i = 0;
		while (weightAt(i) < abs(number)) {
			i++;
		}
		i++;

		final digits = [-2, -1, 0, 1, 2];
		final snafu = [];
		while (i-- > 0) {
			final weight = weightAt(i);
			final bestFit = digits.min64(digit -> abs(number - digit * weight)).list[0];
			number -= bestFit * weight;
			if (bestFit != 0 || snafu.length > 0) {
				snafu[i] = bestFit;
			}
		}
		if (number != 0) {
			throw 'conversion failed';
		}
		return snafu.reversed().map(digit -> switch digit {
			case -2: "=";
			case -1: "-";
			case _: string(digit);
		}).join("");
	}

	public static function findFuelSumAsSnafu(input:String):String {
		return decimalToSnafu(input.lines().map(snafuToDecimal).sum());
	}
}
