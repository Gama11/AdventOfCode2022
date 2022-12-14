package days;

private typedef Monkey = {
	final items:Array<Int>;
	var inspections:Int;
	final operation:{
		final kind:Operator;
		final operand:Operand;
	};
	final test:{
		final divideBy:Int;
		final success:Int;
		final failure:Int;
	};
}

private enum Operator {
	Plus;
	Multiply;
}

private enum Operand {
	Old;
	Value(value:Int);
}

class Day11 {
	static function parse(input:String):Array<Monkey> {
		return input.split("\n\n").map(function(block) {
			final regex = new EReg("
Monkey \\d+:
  Starting items: (.+)
  Operation: new = old ([+*]) (\\d+|old)
  Test: divisible by (\\d+)
    If true: throw to monkey (\\d+)
    If false: throw to monkey (\\d+)
".trim()
				.replace("\r", ""), "");
			if (!regex.match(block)) {
				throw 'no match for $block!';
			}
			return {
				items: regex.matched(1).split(", ").map(parseInt),
				inspections: 0,
				operation: {
					kind: if (regex.matched(2) == "+") Plus else Multiply,
					operand: if (regex.matched(3) == "old") Old else Value(regex.int(3)),
				},
				test: {
					divideBy: regex.int(4),
					success: regex.int(5),
					failure: regex.int(6),
				}
			};
		});
	}

	static function calculateMonkeyBusiness(monkeys:Array<Monkey>, rounds:Int, manageWorry:(Int) -> Int):Int {
		for (_ in 0...rounds) {
			for (monkey in monkeys) {
				while (monkey.items.length > 0) {
					var worryLevel = monkey.items.shift();
					final operand = switch monkey.operation.operand {
						case Old: worryLevel;
						case Value(value): value;
					}
					switch monkey.operation.kind {
						case Plus:
							worryLevel += operand;
						case Multiply:
							worryLevel *= operand;
					}
					worryLevel = manageWorry(worryLevel);

					final nextMonkey = if (worryLevel % monkey.test.divideBy == 0) {
						monkey.test.success;
					} else {
						monkey.test.failure;
					}
					monkeys[nextMonkey].items.push(worryLevel);
					monkey.inspections++;
				}
			}
		}
		return monkeys.map(m -> m.inspections).sorted().splice(-2, 2).product();
	}

	public static function calculateMonkeyBusiness1(input:String):Int {
		return calculateMonkeyBusiness(parse(input), 20, worryLevel -> floor(worryLevel / 3));
	}

	public static function calculateMonkeyBusiness2(input:String):Int {
		final monkeys = parse(input);
		final range = monkeys.map(m -> m.test.divideBy).product();
		return calculateMonkeyBusiness(monkeys, 10000, worryLevel -> mod(worryLevel, range));
	}
}
