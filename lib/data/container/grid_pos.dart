import 'package:flutter/semantics.dart';

class GridPos {
  int x, y;
  GridPos(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GridPos && runtimeType == other.runtimeType && x == other.x && y == other.y);

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Pair($x, $y)';

  static GridPos fromGlobalPos(Offset pos, double gridSize) {
    final doubleGridPos = pos / gridSize;
    return GridPos(doubleGridPos.dx.floor(), doubleGridPos.dy.floor());
  }
}