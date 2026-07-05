import 'package:flutter/material.dart';
import 'package:scribby/data/scribble/stroke/brush/brush.dart';

class LinearBrush extends Brush {
  final double _minWidth, _maxWidth;
  
  LinearBrush(this._minWidth, this._maxWidth, super._color);

  static LinearBrush defaultBrush(Color color) => LinearBrush(0.0, 5.0, color);

  @override
  double pressureToWidth(double pressure) => _minWidth + (_maxWidth - _minWidth) * pressure;
}
