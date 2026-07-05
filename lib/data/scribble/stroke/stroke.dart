import 'dart:math';
import 'dart:ui';

import 'package:scribby/data/scribble/scribble_content.dart';
import 'package:scribby/data/scribble/stroke/brush/brush.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

class Stroke extends ScribbleContent {
  final List<StrokePoint> _strokePoints;
  final Brush _brush;

  Rect? _rectInGlobalSpace;

  Stroke._(this._strokePoints, this._brush);

  /// Return null if rawStrokePoints is empty
  static Stroke? fromRawStrokePoints(List<RawStrokePoint> rawStrokePoints, { required Brush brush }) {
    if (rawStrokePoints.isEmpty) return null;
    return Stroke._(
      rawStrokePoints.map(
        (rawStrokePoint) => rawStrokePoint.toStrokePoint(brush)
      ).toList(), 
      brush
    );
  }

  /// Return null if strokePoints is empty
  static Stroke? fromStrokePoints(List<StrokePoint> strokePoints, { required Brush brush }) {
    if (strokePoints.isEmpty) return null;
    return Stroke._(strokePoints, brush);
  }

  Color get color => _brush.color;
  Brush get brush => _brush;
  List<StrokePoint> get strokePoints => _strokePoints;

  @override
  Rect get rectInGlobalSpace {
    if (_rectInGlobalSpace == null) {
      final firstPointPos = _strokePoints.first.position;
      final firstPointRadius = _strokePoints.first.width / 2;
      double left = firstPointPos.dx - firstPointRadius, right = firstPointPos.dx + firstPointRadius;
      double top = firstPointPos.dy - firstPointRadius, bottom = firstPointPos.dy + firstPointRadius;
      
      for (final strokePoint in _strokePoints.skip(1)) {
        final strokePointPos = strokePoint.position;
        final strokePointRadius = strokePoint.width / 2;
        
        left = min(strokePointPos.dx - strokePointRadius, left);
        right = max(strokePointPos.dx + strokePointRadius, right);
        top = min(strokePointPos.dy - strokePointRadius, top);
        bottom = max(strokePointPos.dy + strokePointRadius, bottom);
      }

      _rectInGlobalSpace = Rect.fromLTRB(left, top, right, bottom);
    }

    return _rectInGlobalSpace!;
  }
}
