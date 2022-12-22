package days;

private enum Shape {
	Rock;
	Paper;
	Scissors;
}

private typedef Round = {
	final opponentMove:Shape;
	final ownMove:Shape;
}

class Day02 {
	static function parse(input:String, resolveMove:(opponent:Shape, letter:String) -> Shape):Array<Round> {
		return input.lines().map(function(line) {
			final parts = line.split(" ");
			final opponentMove = switch parts[0] {
				case "A": Rock;
				case "B": Paper;
				case "C": Scissors;
				case _: throw 'invalid';
			};
			return {
				opponentMove: opponentMove,
				ownMove: resolveMove(opponentMove, parts[1]),
			};
		});
	}

	public static function resolveAsShape(_, letter:String) {
		return switch letter {
			case "X": Rock;
			case "Y": Paper;
			case "Z": Scissors;
			case _: throw 'invalid';
		}
	}

	public static function resolveAsOutcome(opponent:Shape, letter:String) {
		return switch letter {
			case "X": switch opponent {
					case Rock: Scissors;
					case Paper: Rock;
					case Scissors: Paper;
				}
			case "Y": opponent;
			case "Z": switch opponent {
					case Rock: Paper;
					case Paper: Scissors;
					case Scissors: Rock;
				}
			case _: throw 'invalid';
		}
	}

	public static function calculateTotalScore(input:String, resolveMove:(opponent:Shape, letter:String) -> Shape):Int {
		final rounds = parse(input, resolveMove);
		return rounds.map(function(round) {
			final shapeScore = switch round.ownMove {
				case Rock: 1;
				case Paper: 2;
				case Scissors: 3;
			}
			final outcomeScore = switch [round.opponentMove, round.ownMove] {
				case [Rock, Paper] | [Paper, Scissors] | [Scissors, Rock]: 6;
				case [Rock, Rock] | [Paper, Paper] | [Scissors, Scissors]: 3;
				case _: 0;
			}
			return shapeScore + outcomeScore;
		}).sum();
	}
}
