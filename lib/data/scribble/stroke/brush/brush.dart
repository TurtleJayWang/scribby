import 'package:flutter/material.dart';

abstract class Brush { 
  final Color _color;

  Brush(this._color);

  double pressureToWidth(double pressure);
  Color get color => _color;
}