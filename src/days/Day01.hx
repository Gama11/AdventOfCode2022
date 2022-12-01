package days;

class Day01 {
	static function parse(input:String) {
		return input.split("\n\n").map(inventory -> inventory.split("\n").map(Std.parseInt));
	}

	public static function findBiggestInventory(input:String):Int {
		final inventories = parse(input);
		return inventories.max(inventory -> inventory.sum()).value;
	}

	public static function sumTopThreeInventories(input:String):Int {
		final inventorySizes = parse(input).map(inventory -> inventory.sum());
		return inventorySizes.sorted().splice(-3, 3).sum();
	}
}
