package days;

private typedef FileSystem = Map<String, FileSystemObject>;

private enum FileSystemObject {
	File(size:Int);
	Directory(content:Array<String>);
}

class Day07 {
	static function parse(input:String):FileSystem {
		final workingDirectory = [];
		final fileSystem = new FileSystem();
		function path() {
			return workingDirectory.join("/");
		}
		function add(name:String) {
			fileSystem.compute(path(), function(value) {
				return switch value ?? Directory([]) {
					case File(_): throw 'unexpected file for ${path()}';
					case Directory(content): Directory(content.concat([name]));
				}
			});
		}
		for (line in input.lines()) {
			switch line.split(" ") {
				case ["$", "cd", ".."]:
					workingDirectory.pop();
				case ["$", "cd", directory]:
					workingDirectory.push(directory);
				case ["$", "ls"]: // ignore
				case ["dir", name]:
					add(name);
				case [parseInt(_) => size, name]:
					add(name);
					fileSystem[path() + "/" + name] = File(size);
				case _:
					throw 'unmatched $line';
			}
		}
		return fileSystem;
	}

	static function calculateSize(fileSystem:FileSystem, path:String, onDirectory:(size:Int) -> Void):Int {
		return switch fileSystem[path] {
			case null: throw 'path $path not found';
			case File(size): size;
			case Directory(content):
				content.map(name -> calculateSize(fileSystem, path + "/" + name, onDirectory)).sum().also(onDirectory);
		}
	}

	public static function sumOfSmallDirectories(input:String):Int {
		final fileSystem = parse(input);
		var sum = 0;
		calculateSize(fileSystem, "/", function(size) {
			if (size <= 100000) {
				sum += size;
			}
		});
		return sum;
	}

	public static function findSizeOfDeletionTarget(input:String):Int {
		final fileSystem = parse(input);
		final unusedSpace = 70000000 - calculateSize(fileSystem, "/", _ -> {});
		final minimumDeletion = 30000000 - unusedSpace;
		var targetSize:Int = null;
		calculateSize(fileSystem, "/", function(size) {
			if (size >= minimumDeletion) {
				targetSize = if (targetSize == null) {
					size;
				} else {
					Std.int(Math.min(targetSize, size));
				}
			}
		});
		return targetSize;
	}
}
