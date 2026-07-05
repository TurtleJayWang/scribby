import 'dart:ui';

import 'package:scribby/data/scribble/stroke/eraser/eraser.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

class SquareEraser extends Eraser {
  final Offset _center;
  final double _width;

  SquareEraser(this._center, this._width);

  @override
  bool shouldErase(StrokePoint strokePoint) {
    final eraserRect = Rect.fromCenter(center: _center, width: _width, height: _width);
    final strokePointPos = strokePoint.position;
    final nearestX = clampDouble(strokePointPos.dx, eraserRect.left, eraserRect.right);
    final nearestY = clampDouble(strokePointPos.dy, eraserRect.top, eraserRect.bottom);
    final nearestPoint = Offset(nearestX, nearestY);

    return (strokePointPos - nearestPoint).distance < strokePoint.width / 2;
  }
}