import 'package:scribby/data/scribble/stroke/stroke.dart';

abstract class Smoother {
  Stroke smooth(Stroke stroke);
}