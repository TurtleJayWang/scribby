import 'package:scribby/data/scribble/stroke/smoother/smoother.dart';
import 'package:scribby/data/scribble/stroke/stroke.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

class ChaikinSmoother extends Smoother {
  final int _smoothLevel;
  
  ChaikinSmoother(this._smoothLevel);

  static ChaikinSmoother getDefault() => ChaikinSmoother(4);

  @override
  Stroke smooth(Stroke stroke) {
    if (stroke.strokePoints.length <= 1) return stroke;

    List<StrokePoint> smoothedPoints = stroke.strokePoints;
    for (int i = 0; i < _smoothLevel; i++) {
      smoothedPoints = _smoothIter(smoothedPoints);
    }
    return Stroke.fromStrokePoints(smoothedPoints, brush: stroke.brush)!;
  }

  List<StrokePoint> _smoothIter(List<StrokePoint> strokePoints) {
    List<StrokePoint> smoothedPoints = [strokePoints.first];

    for (int i = 1; i < strokePoints.length; i++) {
      final point1 = strokePoints[i - 1];
      final point2 = strokePoints[i];
      final newPoint1Pos = point1.position * 0.75 + point2.position * 0.25;
      final newPoint2Pos = point1.position * 0.25 + point2.position * 0.75;
      final newPoint1Width = point1.width * 0.75 + point2.width + 0.25;
      final newPoint2Width = point1.width * 0.25 + point2.width + 0.75;
      smoothedPoints.add(StrokePoint(newPoint1Pos, newPoint1Width));
      smoothedPoints.add(StrokePoint(newPoint2Pos, newPoint2Width));
    }

    smoothedPoints.add(strokePoints.last);

    return smoothedPoints;
  } 
}