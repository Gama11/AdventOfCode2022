package days;

private enum Packet {
	Integer(value:Int);
	List(packets:Array<Packet>);
}

private typedef Stream = {
	final string:String;
	var i:Int;
}

private enum abstract Decision(Int) from Int to Int {
	final Correct = -1;
	final Incorrect = 0;
	final Continue = 1;
}

class Day13 {
	static function printPacket(packet:Packet) {
		return switch packet {
			case Integer(value): Std.string(value);
			case List(packets): "[" + packets.map(printPacket).join(",") + "]";
		}
	}

	public static function printPacketPairs(packets:Array<Array<Packet>>):String {
		return packets.map(pair -> pair.map(printPacket).join("\n")).join("\n\n");
	}

	public static function parsePacketPairs(input:String):Array<Array<Packet>> {
		final pairs = input.split("\n\n").map(pair -> pair.lines());
		function parsePacket(stream:Stream):Packet {
			var list:Array<Packet> = null;
			while (true) {
				switch stream.string.charAt(stream.i++) {
					case "[":
						if (list == null) {
							list = [];
						} else {
							stream.i--;
							list.push(parsePacket(stream));
						}
					case "]":
						return List(list);
					case ",":
						if (list == null) {
							throw "not a list";
						} else {
							list.push(parsePacket(stream));
						}
					case int:
						var acc = int;
						while (true) {
							final char = stream.string.charAt(stream.i);
							if (parseInt(char) != null) {
								acc += char;
								stream.i++;
							} else {
								break;
							}
						}
						final integer = Integer(parseInt(acc));
						if (list == null) {
							return integer;
						} else {
							list.push(integer);
						}
				}
			}
		}
		return pairs.map(pair -> pair.map(packet -> parsePacket({string: packet, i: 0})));
	}

	static function compare(p1:Packet, p2:Packet):Decision {
		return switch [p1, p2] {
			case [Integer(v1), Integer(v2)]: switch (v1 - v2).sign() {
					case -1: Correct;
					case 0: Continue;
					case 1: Incorrect;
					case _: throw 'unreachable';
				}
			case [Integer(_), List(_)]: compare(List([p1]), p2);
			case [List(_), Integer(_)]: compare(p1, List([p2]));
			case [List(l1), List(l2)]:
				for (i in 0...Std.int(Math.max(l1.length, l2.length))) {
					if (l1[i] == null) {
						return Correct;
					}
					if (l2[i] == null) {
						return Incorrect;
					}
					final decision = compare(l1[i], l2[i]);
					if (decision != Continue) {
						return decision;
					}
				}
				return Continue;
		}
	}

	public static function sumCorrectlyOrderedIndices(input:String):Int {
		return parsePacketPairs(input) //
			.withIndices()
			.filter(it -> compare(it.item[0], it.item[1]) == Correct)
			.map(it -> it.index + 1)
			.sum();
	}

	public static function findDecoderKey(input:String):Int {
		final dividers = [2, 6].map(i -> {packet: List([List([Integer(i)])]), divider: true});
		return parsePacketPairs(input) //
			.flatten()
			.map(packet -> {packet: packet, divider: false})
			.concat(dividers)
			.sorted((a, b) -> compare(a.packet, b.packet))
			.withIndices()
			.mapNotNull(it -> if (it.item.divider) it.index + 1 else null)
			.product();
	}
}
