import sys.io.File;
import sys.FileSystem;

using StringTools;

function main() {
	Sys.setCwd("data");
	final days = FileSystem.readDirectory(".").filter(FileSystem.isDirectory).map(path -> Std.parseInt(path.replace("day", "")));
	days.sort(Reflect.compare);
	final day = days[days.length - 1] + 1;
	final dataDir = 'day$day';
	FileSystem.createDirectory(dataDir);
	File.saveContent('$dataDir/example.txt', "");
	File.saveContent('$dataDir/input.txt', "");
	Sys.setCwd("..");

	File.saveContent('src/days/Day$day.hx', '
package days;

class Day$day {
	static function parse(input:String) {
		return input;
	}

	public static function solve(input:String):Int {
		final parsed = parse(input);
		
		return 0;
	}
}'.trim());

	final testsPath = "src/Tests.hx";
	var testsContent = File.getContent(testsPath);
	testsContent = testsContent.replace("\t}\r\n}", '\t}\r\n
	function specDay$day() {
		0 == Day$day.solve(data("day$day/example"));
		0 == Day$day.solve(data("day$day/input"));
	}
}');
	File.saveContent(testsPath, testsContent);
}
