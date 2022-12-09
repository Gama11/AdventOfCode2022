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
}
