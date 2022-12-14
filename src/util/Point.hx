package util;

import polygonal.ds.Hashable;

@:forward
@:forward.new
abstract Point(PointImpl) from PointImpl to Hashable {
	@:op(A + B) inline function add(point:Point):Point {
		return new Point(this.x + point.x, this.y + point.y);
	}

	@:op(A - B) inline function subtract(point:Point):Point {
		return new Point(this.x - point.x, this.y - point.y);
	}

	@:op(A * B) inline function scale(n:Float):Point {
		return new Point(Std.int(this.x * n), Std.int(this.y * n));
	}

	@:op(A == B) inline function equals(point:Point):Bool {
		return this.x == point.x && this.y == point.y;
	}

	@:op(A != B) inline function notEquals(point:Point):Bool {
		return !equals(point);
	}

	public inline function inverted():Point {
		return new Point(-this.x, -this.y);
	}

	public function sign():Point {
		return new Point(this.x.sign(), this.y.sign());
	}
}

private class PointImpl implements Hashable {
	public final x:Int;
	public final y:Int;

	public var key(default, null):Int;

	public inline function new(x, y) {
		this.x = x;
		this.y = y;
		key = x + 10000 * y;
	}

	public function distanceTo(point:Point):Int {
		return Std.int(Math.abs(x - point.x) + Math.abs(y - point.y));
	}

	public function shortString():String {
		return '$x,$y';
	}

	public function toString():String {
		return '($x, $y)';
	}
}
