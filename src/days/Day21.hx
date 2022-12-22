package days;

private abstract Monkey(String) to String {
	public static final Root = new Monkey("root");
	public static final Human = new Monkey("humn");

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

	static function eval(monkeys:Map<Monkey, Expr>, monkey:Monkey):Int64 {
		return switch monkeys[monkey] {
			case Value(value): value;
			case Binop(lhs, kind, rhs): switch kind {
					case Addition: eval(monkeys, lhs) + eval(monkeys, rhs);
					case Subtraction: eval(monkeys, lhs) - eval(monkeys, rhs);
					case Multiplication: eval(monkeys, lhs) * eval(monkeys, rhs);
					case Division: eval(monkeys, lhs) / eval(monkeys, rhs);
				}
		}
	}

	public static function findRootMonkeyOutput(input:String):Int64 {
		return eval(parse(input), Monkey.Root);
	}

	public static function findCorrectHumanInput(input:String):Int64 {
		final monkeys = parse(input);
		
		function containsVariable(monkey:Monkey) {
			return switch monkeys[monkey] {
				case Value(_): monkey == Monkey.Human;
				case Binop(lhs, _, rhs): containsVariable(lhs) || containsVariable(rhs);
			}
		}
		var solution:Int64 = null;
		var unsolvedSide = Monkey.Root;

		function transform(monkey:Monkey, operation:Operation, value:Int64, lhs:Bool) {
			switch operation {
				case _ if (monkey == Monkey.Root):
					solution = value;
				case Addition:
					solution -= value;
				case Subtraction if (lhs):
					solution += value;
				case Subtraction if (!lhs):
					solution -= value;
					solution *= -1;
				case Multiplication:
					solution /= value;
				case Division if (lhs):
					solution *= value;
				case Division if (!lhs):
					solution = value / solution;
				case _:
					throw 'unreachable';
			}
		}

		function solve(monkey:Monkey) {
			switch monkeys[monkey] {
				case Binop(lhs, kind, rhs) if (containsVariable(lhs)):
					transform(monkey, kind, eval(monkeys, rhs), true);
					unsolvedSide = lhs;
				case Binop(lhs, kind, rhs) if (containsVariable(rhs)):
					transform(monkey, kind, eval(monkeys, lhs), false);
					unsolvedSide = rhs;
				case _:
					throw 'expected binop';
			}
		}

		while (unsolvedSide != Monkey.Human) {
			solve(unsolvedSide);
		}
		return solution;
	}
}
