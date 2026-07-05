import 'package:flutter/material.dart';
import 'package:scribby/data/scribble/stroke/brush/brush.dart';

class StrokePoint {
  final Offset _position;
  final double _width;
  
  StrokePoint(this._position, this._width);

  Offset get position => _position;
  double get width => _width;
}

class RawStrokePoint {
  final Offset _position;
  final double _pressure;

  RawStrokePoint(this._position, this._pressure);

  Offset get position => _position;
  double get pressure => _pressure;

  StrokePoint toStrokePoint(Brush brush) => StrokePoint(_position, brush.pressureToWidth(_pressure));
}
