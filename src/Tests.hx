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
	}
}
