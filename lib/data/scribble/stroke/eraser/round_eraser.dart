import 'package:flutter/material.dart';
import 'package:scribby/data/scribble/stroke/eraser/eraser.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

class RoundEraser extends Eraser {
  final Offset _center;
  final double _radius;

  RoundEraser(this._center, this._radius);
  
  @override
  bool shouldErase(StrokePoint strokePoint) {
    final strokePointPos = strokePoint.position;
    final strokePointRadius = strokePoint.width / 2;
    return (strokePointPos - _center).distance < (strokePointRadius + _radius);
  }
}