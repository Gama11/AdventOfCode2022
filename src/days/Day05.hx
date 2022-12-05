package days;

class Day05 {
	static function parse(input:String) {
		final parts = input.split("\n\n");
		final slices = parts[0].split("\n").map(l -> l.split("")).slice(0, -1);
		final stacks = [];
		for (slice in slices) {
			var i = 0;
			while (true) {
				final crate = slice[4 * i + 1] ?? break;
				if (crate != " ") {
					final stack = stacks[i] ?? [];
					stack.unshift(crate);
					stacks[i] = stack;
				}
				i++;
			}
		}
		final procedure = parts[1].split("\n").map(function(line) {
			final regex = ~/move (\d+) from (\d+) to (\d+)/;
			regex.match(line);
			return {
				amount: regex.int(1),
				from: regex.int(2),
				to: regex.int(3),
			};
		});
		return {
			stacks: stacks,
			procedure: procedure,
		};
	}

	public static function findTopCrates(input:String):String {
		final parsed = parse(input);
		final stacks = parsed.stacks;
		for (step in parsed.procedure) {
			for (_ in 0...step.amount) {
				final crate = stacks[step.from - 1].pop();
				stacks[step.to - 1].push(crate);
			}
		}
		return stacks.map(s -> s.last()).join("");
	}
}
