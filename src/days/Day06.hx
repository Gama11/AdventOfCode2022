package days;

class Day06 {
	static function findMarkerOffset(input:String, consecutiveChars:Int):Int {
		final chars = input.split("");
		var marker = [];
		for (i => char in chars) {
			while (marker.contains(char)) {
				marker.shift();
			}
			marker.push(char);
			
			if (marker.length == consecutiveChars) {
				return i + 1;
			}
		}
		throw "no marker found";
	}

	public static function findStartOfPacket(input:String):Int {
		return findMarkerOffset(input, 4);
	}

	public static function findStartOfMessage(input:String):Int {
		return findMarkerOffset(input, 14);
	}
}
