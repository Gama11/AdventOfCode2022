import days.*;
import sys.io.File;
import utest.ITest;
import utest.UTest;
import haxe.Int64.parseString as int64;

class Tests implements ITest {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function data(name:String):String {
		return File.getContent('data/$name.txt').replace("\r", "");
	}

	#if !only_current_day
	function specDay01() {
		24000 == Day01.findBiggestInventory(data("day01/example"));
		67658 == Day01.findBiggestInventory(data("day01/input"));

		45000 == Day01.sumTopThreeInventories(data("day01/example"));
		200158 == Day01.sumTopThreeInventories(data("day01/input"));
	}

	function specDay02() {
		15 == Day02.calculateTotalScore(data("day02/example"), Day02.resolveAsShape);
		15632 == Day02.calculateTotalScore(data("day02/input"), Day02.resolveAsShape);

		12 == Day02.calculateTotalScore(data("day02/example"), Day02.resolveAsOutcome);
		14416 == Day02.calculateTotalScore(data("day02/input"), Day02.resolveAsOutcome);
	}

	function specDay03() {
		157 == Day03.sumPriorities(data("day03/example"));
		7746 == Day03.sumPriorities(data("day03/input"));

		70 == Day03.sumGroupPriorities(data("day03/example"));
		2604 == Day03.sumGroupPriorities(data("day03/input"));
	}

	function specDay04() {
		2 == Day04.countFullyContainedPairs(data("day04/example"));
		431 == Day04.countFullyContainedPairs(data("day04/input"));

		4 == Day04.countOverlappingPairs(data("day04/example"));
		823 == Day04.countOverlappingPairs(data("day04/input"));
	}

	function specDay05() {
		"CMZ" == Day05.findTopCrates(data("day05/example"), false);
		"TQRFCBSJJ" == Day05.findTopCrates(data("day05/input"), false);

		"MCD" == Day05.findTopCrates(data("day05/example"), true);
		"RMHFJNVFP" == Day05.findTopCrates(data("day05/input"), true);
	}

	function specDay06() {
		7 == Day06.findStartOfPacket("mjqjpqmgbljsphdztnvjfqwrcgsmlb");
		5 == Day06.findStartOfPacket("bvwbjplbgvbhsrlpgdmjqwftvncz");
		6 == Day06.findStartOfPacket("nppdvjthqldpwncqszvftbrmjlhg");
		10 == Day06.findStartOfPacket("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg");
		11 == Day06.findStartOfPacket("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw");
		1080 == Day06.findStartOfPacket(data("day06/input"));

		19 == Day06.findStartOfMessage("mjqjpqmgbljsphdztnvjfqwrcgsmlb");
		23 == Day06.findStartOfMessage("bvwbjplbgvbhsrlpgdmjqwftvncz");
		23 == Day06.findStartOfMessage("nppdvjthqldpwncqszvftbrmjlhg");
		29 == Day06.findStartOfMessage("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg");
		26 == Day06.findStartOfMessage("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw");
		3645 == Day06.findStartOfMessage(data("day06/input"));
	}

	function specDay07() {
		95437 == Day07.sumOfSmallDirectories(data("day07/example"));
		1243729 == Day07.sumOfSmallDirectories(data("day07/input"));

		24933642 == Day07.findSizeOfDeletionTarget(data("day07/example"));
		4443914 == Day07.findSizeOfDeletionTarget(data("day07/input"));
	}

	function specDay08() {
		21 == Day08.countVisibleTrees(data("day08/example"));
		1818 == Day08.countVisibleTrees(data("day08/input"));

		8 == Day08.findHighestScenicScore(data("day08/example"));
		368368 == Day08.findHighestScenicScore(data("day08/input"));
	}

	function specDay09() {
		13 == Day09.countVisitedPositions(data("day09/example"), 2);
		6081 == Day09.countVisitedPositions(data("day09/input"), 2);

		1 == Day09.countVisitedPositions(data("day09/example"), 10);
		36 == Day09.countVisitedPositions(data("day09/example2"), 10);
		2487 == Day09.countVisitedPositions(data("day09/input"), 10);
	}

	function specDay10() {
		13140 == Day10.sumSignalStrengths(data("day10/example"));
		15260 == Day10.sumSignalStrengths(data("day10/input"));
	}

	function specDay11() {
		10605 == Day11.calculateMonkeyBusiness1(data("day11/example"));
		55458 == Day11.calculateMonkeyBusiness1(data("day11/input"));

		2713310158 == Day11.calculateMonkeyBusiness2(data("day11/example"));
		14508081294 == Day11.calculateMonkeyBusiness2(data("day11/input"));
	}

	function specDay12() {
		31 == Day12.findFewestSteps(data("day12/example"), ["S"]);
		520 == Day12.findFewestSteps(data("day12/input"), ["S"]);

		29 == Day12.findFewestSteps(data("day12/example"), ["S", "a"]);
		508 == Day12.findFewestSteps(data("day12/input"), ["S", "a"]);
	}

	function specDay13() {
		final example = data("day13/example");
		final input = data("day13/input");

		example == Day13.printPacketPairs(Day13.parsePacketPairs(example));
		input == Day13.printPacketPairs(Day13.parsePacketPairs(input));

		13 == Day13.sumCorrectlyOrderedIndices(example);
		5852 == Day13.sumCorrectlyOrderedIndices(input);

		140 == Day13.findDecoderKey(example);
		24190 == Day13.findDecoderKey(input);
	}

	function specDay14() {
		24 == Day14.countRestingSand(data("day14/example"), false);
		618 == Day14.countRestingSand(data("day14/input"), false);

		93 == Day14.countRestingSand(data("day14/example"), true);
		26358 == Day14.countRestingSand(data("day14/input"), true);
	}

	function specDay15() {
		26 == Day15.countExcludedPositionsInRow(data("day15/example"), 10);
		5878678 == Day15.countExcludedPositionsInRow(data("day15/input"), 2000000);

		56000011 == Day15.findTuningFrequency(data("day15/example"), 20);
		11796491041245 == Day15.findTuningFrequency(data("day15/input"), 4000000);
	}
	#end

	function specDay18() {
		10 == Day18.calculateSurfaceArea(data("day18/example1"));
		64 == Day18.calculateSurfaceArea(data("day18/example2"));
		4444 == Day18.calculateSurfaceArea(data("day18/input"));

		58 == Day18.calculateExteriorSurfaceArea(data("day18/example2"));
		2530 == Day18.calculateExteriorSurfaceArea(data("day18/input"));
	}
}
