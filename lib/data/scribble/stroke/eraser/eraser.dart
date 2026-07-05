import 'package:scribby/data/scribble/stroke/stroke_point.dart';

abstract class Eraser {
  bool shouldErase(StrokePoint strokePoint); 
}
