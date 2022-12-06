package days;

class Day06 {
	public static function findMarkerOffset(input:String):Int {
		final chars = input.split("");
		var marker = [];
		for (i => char in chars) {
			while (marker.contains(char)) {
				marker.shift();
			}
			marker.push(char);
			
			if (marker.length == 4) {
				return i + 1;
			}
		}
		throw "no marker found";
	}
}
