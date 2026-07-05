import 'package:scribby/data/scribble/stroke/smoother/smoother.dart';
import 'package:scribby/data/scribble/stroke/stroke.dart';

class NoSmoother extends Smoother {
  @override
  Stroke smooth(Stroke stroke) {
    return stroke;
  }
}