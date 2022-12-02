package days;

private enum Shape {
	Rock;
	Paper;
	Scissors;
}

private typedef Round = {
	final opponentMove: Shape;
	final ownMove: Shape;
}

class Day02 {
	static function parse(input:String):Array<Round> {
		return input.split("\n").map(function(line) {
			final parts = line.split(" ");
			return {
				opponentMove: switch parts[0] {
					case "A": Rock;
					case "B": Paper;
					case "C": Scissors;
					case _: throw 'invalid';
				},
				ownMove: switch parts[1] {
					case "X": Rock;
					case "Y": Paper;
					case "Z": Scissors;
					case _: throw 'invalid';
				}
			};
		});
	}

	public static function calculateTotalScore(input:String):Int {
		final rounds = parse(input);
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
