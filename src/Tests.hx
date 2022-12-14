import days.Day22.CubeLayout;
import days.Day22.CubeWrappingAlgorithm;
import days.Day22.FlatWrappingAlgorithm;
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
		return File.getContent('data/$name.txt').remove("\r");
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

	function specDay17() {
		3068 == Day17.determineTowerHeight(data("day17/example"), 2022);
		3147 == Day17.determineTowerHeight(data("day17/input"), 2022);

		1514285714288i64 == Day17.determineTowerHeight(data("day17/example"), 1000000000000i64);
		1532163742758i64 == Day17.determineTowerHeight(data("day17/input"), 1000000000000i64);
	}

	function specDay18() {
		10 == Day18.calculateSurfaceArea(data("day18/example1"));
		64 == Day18.calculateSurfaceArea(data("day18/example2"));
		4444 == Day18.calculateSurfaceArea(data("day18/input"));

		58 == Day18.calculateExteriorSurfaceArea(data("day18/example2"));
		2530 == Day18.calculateExteriorSurfaceArea(data("day18/input"));
	}

	function specDay20() {
		3 == Day20.findGroveCoordinates(data("day20/example"), 1, 1);
		4066 == Day20.findGroveCoordinates(data("day20/input"), 1, 1);

		1623178306 == Day20.findGroveCoordinates(data("day20/example"), 10, 811589153);
		6704537992933 == Day20.findGroveCoordinates(data("day20/input"), 10, 811589153);
	}

	function specDay21() {
		152 == Day21.findRootMonkeyOutput(data("day21/example"));
		276156919469632i64 == Day21.findRootMonkeyOutput(data("day21/input"));

		301 == Day21.findCorrectHumanInput(data("day21/example"));
		3441198826073i64 == Day21.findCorrectHumanInput(data("day21/input"));
	}
	#end

	function specDay22() {
		6032 == Day22.findPassword(data("day22/example"), FlatWrappingAlgorithm.new);
		80392 == Day22.findPassword(data("day22/input"), FlatWrappingAlgorithm.new);

		5031 == Day22.findPassword(data("day22/example"), CubeWrappingAlgorithm.new.bind(4, CubeLayout.Example));
		19534 == Day22.findPassword(data("day22/input"), CubeWrappingAlgorithm.new.bind(50, CubeLayout.Input));
	}

	#if !only_current_day
	function specDay23() {
		110 == Day23.countEmptyTilesBetweenElves(data("day23/example"));
		3780 == Day23.countEmptyTilesBetweenElves(data("day23/input"));

		20 == Day23.findFirstRoundWithoutMovement(data("day23/example"));
		930 == Day23.findFirstRoundWithoutMovement(data("day23/input"));
	}

	function specDay24() {
		18 == Day24.findQuickestPathWithoutSnacks(data("day24/example"));
		288 == Day24.findQuickestPathWithoutSnacks(data("day24/input"));

		54 == Day24.findQuickestPathWithSnacks(data("day24/example"));
		861 == Day24.findQuickestPathWithSnacks(data("day24/input"));
	}

	function specDay25() {
		"2=-1=0" == Day25.findFuelSumAsSnafu(data("day25/example"));
		"2-0-01==0-1=2212=100" == Day25.findFuelSumAsSnafu(data("day25/input"));
	}
	#end
}
