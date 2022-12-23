package days;

class Day20 {
	public static function findGroveCoordinates(input:String):Int {
		final original = input.splitToInt("\n").map(n -> {value: n});
		final mixed = original.copy();
		for (number in original) {
			var index = mixed.indexOf(number);
			mixed.splice(index, 1);

			var newIndex = Util.mod(index + number.value, mixed.length);
			mixed.insert(newIndex, number);
		}

		final zeroIndex = mixed.findIndex(n -> n.value == 0);
		function numberAt(index:Int):Int {
			return mixed[(zeroIndex + index) % mixed.length].value;
		}
		return numberAt(1000) + numberAt(2000) + numberAt(3000);
	}
}
