package days;

private typedef Rucksack = {
	final compartment1:Array<String>;
	final compartment2:Array<String>;
}

class Day03 {
	static function parse(input:String):Array<Rucksack> {
		return input.lines().map(function(line) {
			final items = line.split("");
			final halfLength = Std.int(items.length / 2);
			return {
				compartment1: items.slice(0, halfLength),
				compartment2: items.slice(halfLength, items.length),
			};
		});
	}

	static function calculateItemPriority(item:String):Int {
		return (if (item.toLowerCase() == item) {
			item.charCodeAt(0) - 'a'.code;
		} else {
			item.charCodeAt(0) - 'A'.code + 26;
		}) + 1;
	}

	public static function sumPriorities(input:String):Int {
		return parse(input).map(function(rucksack) {
			final duplicate = rucksack.compartment1.unique().intersection(rucksack.compartment2.unique())[0];
			return calculateItemPriority(duplicate);
		}).sum();
	}

	public static function sumGroupPriorities(input:String):Int {
		return parse(input).chunked(3).map(function(group) {
			final uniquesPerRucksack = group.map(rucksack -> rucksack.compartment1.concat(rucksack.compartment2).unique());
			final badge = uniquesPerRucksack.fold((item, result) -> item.intersection(result), uniquesPerRucksack[0])[0];
			return calculateItemPriority(badge);
		}).sum();
	}
}
