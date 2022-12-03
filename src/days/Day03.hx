package days;

private typedef Rucksack = {
	final compartment1:Array<String>;
	final compartment2:Array<String>;
}

class Day03 {
	static function parse(input:String):Array<Rucksack> {
		return input.split("\n").map(function(line) {
			final items = line.split("");
			final halfLength = Std.int(items.length / 2);
			return {
				compartment1: items.slice(0, halfLength),
				compartment2: items.slice(halfLength, items.length),
			};
		});
	}

	public static function sumPriorities(input:String):Int {
		final rucksacks = parse(input);
		return rucksacks.map(function(rucksack) {
			final duplicate = rucksack.compartment1.unique().intersection(rucksack.compartment2.unique())[0];
			return (if (duplicate.toLowerCase() == duplicate) {
				duplicate.charCodeAt(0) - 'a'.code;
			} else {
				duplicate.charCodeAt(0) - 'A'.code + 26;
			}) + 1;
		}).sum();
	}
}
