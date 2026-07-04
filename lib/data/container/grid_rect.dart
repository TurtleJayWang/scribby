import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:scribby/data/container/grid_pos.dart';

class GridRect {
  final GridPos _topLeft;
  final GridPos _bottomRight;

  GridRect._(this._topLeft, this._bottomRight);

  List<GridPos> getGridPositionsInRect() {
    List<GridPos> gridPositions = [];
    for (int i = _topLeft.x; i <= _bottomRight.x; i++) {
      for (int j = _topLeft.y; j <= _bottomRight.y; j++) {
        gridPositions.add(GridPos(i, j));
      }
    }
    return gridPositions;
  }

  static GridRect fromRectAndGridSize(Rect rect, double gridSize) {
    final gridTopLeft = GridPos.fromGlobalPos(rect.topLeft, gridSize);
    final gridBottomRight = GridPos.fromGlobalPos(rect.bottomRight, gridSize);
    return GridRect._(gridTopLeft, gridBottomRight);
  }

  static GridRect fromTLBR(GridPos topLeft, GridPos bottomRight) {
    return GridRect._(topLeft, bottomRight);
  }

  static GridRect fromTLWH(GridPos topLeft, int width, int height) {
    return GridRect._(topLeft, GridPos(topLeft.x + width, topLeft.y + height));
  }

  int get left => _topLeft.x;
  int get top => _topLeft.y;
  int get right => _bottomRight.x;
  int get bottom => _bottomRight.y;

  GridPos get topLeft => _topLeft;
  GridPos get topRight => GridPos(_bottomRight.x, _topLeft.y);
  GridPos get bottomLeft => GridPos(_topLeft.x, _bottomRight.y);
  GridPos get bottomRight => _bottomRight;

}