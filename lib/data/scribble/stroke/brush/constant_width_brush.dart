import 'package:scribby/data/scribble/stroke/brush/brush.dart';

class ConstantWidthBrush extends Brush {
  final double _width;
  
  ConstantWidthBrush(this._width, super._color);

  @override
  double pressureToWidth(double pressure) => _width;
}