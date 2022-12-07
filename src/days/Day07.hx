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
		for (line in input.split("\n")) {
			switch line.split(" ") {
				case ["$", "cd", ".."]:
					workingDirectory.pop();
				case ["$", "cd", directory]:
					workingDirectory.push(directory);
				case ["$", "ls"]: // ignore
				case ["dir", name]:
					add(name);
				case [Std.parseInt(_) => size, name]:
					add(name);
					fileSystem[path() + "/" + name] = File(size);
				case _:
					throw 'unmatched $line';
			}
		}
		return fileSystem;
	}

	public static function sumOfSmallDirectories(input:String):Int {
		final fileSystem = parse(input);
		final smallDirectories = [];
		function size(path:String):Int {
			return switch fileSystem[path] {
				case null: throw 'path $path not found';
				case File(size): size;
				case Directory(content):
					content.map(name -> size(path + "/" + name)).sum().also(function(size) {
						if (size <= 100000) {
							smallDirectories.push(size);
						}
					});
			}
		}
		size("/");
		return smallDirectories.sum();
	}
}
