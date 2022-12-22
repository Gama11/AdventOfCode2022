package days;

private abstract Monkey(String) to String {
	public inline function new(value)
		this = value;
}

private enum Expr {
	Value(value:Int);
	Binop(lhs:Monkey, kind:Operation, rhs:Monkey);
}

private enum Operation {
	Addition;
	Subtraction;
	Multiplication;
	Division;
}

class Day21 {
	static function parse(input:String):Map<Monkey, Expr> {
		final monkeys = new Map<Monkey, Expr>();
		for (line in input.lines()) {
			switch line.remove(":").split(" ") {
				case [name, value]:
					monkeys[new Monkey(name)] = Value(parseInt(value));
				case [name, lhs, operation, rhs]:
					monkeys[new Monkey(name)] = Binop(new Monkey(lhs), switch operation {
						case "+": Addition;
						case "-": Subtraction;
						case "*": Multiplication;
						case "/": Division;
						case _: throw 'unexpected operation';
					}, new Monkey(rhs));
				case v:
					throw 'unexpected $v';
			}
		}
		return monkeys;
	}

	public static function findRootMonkeyOutput(input:String):Int64 {
		final monkeys = parse(input);
		function eval(monkey:Monkey):Int64 {
			return switch monkeys[monkey] {
				case Value(value): value;
				case Binop(lhs, kind, rhs): switch kind {
					case Addition: eval(lhs) + eval(rhs);
					case Subtraction: eval(lhs) - eval(rhs);
					case Multiplication: eval(lhs) * eval(rhs);
					case Division: eval(lhs) / eval(rhs);
				}
			}
		}
		return eval(new Monkey("root"));
	}
}
