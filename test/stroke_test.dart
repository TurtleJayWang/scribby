import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scribby/data/scribble/stroke/brush/linear_brush.dart';
import 'package:scribby/data/scribble/stroke/smoother/chaikin_smoother.dart';
import 'package:scribby/data/scribble/stroke/stroke.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

void main() {
  List<RawStrokePoint> rawPoints = [
    RawStrokePoint(Offset(1.0, 0.5), 0.5),
    RawStrokePoint(Offset(2.0, 0.3), 0.5),
    RawStrokePoint(Offset(4.0, 0.4), 0.5),
    RawStrokePoint(Offset(3.0, 0.3), 0.5),
    RawStrokePoint(Offset(3.1, 0.25), 0.5),
    RawStrokePoint(Offset(2.8, 0.2), 0.5),
    RawStrokePoint(Offset(2.1, 0.15), 0.5),
    RawStrokePoint(Offset(1.8, 0.05), 0.5),
    RawStrokePoint(Offset(1.4, -0.8), 0.5),
    RawStrokePoint(Offset(1.0, 0.6), 0.5),
    RawStrokePoint(Offset(0.8, 0.4), 0.5),
    RawStrokePoint(Offset(-0.2, 0.2), 0.5),
  ];

  final smoother = ChaikinSmoother(4);

  final stroke = Stroke.fromRawStrokePoints(rawPoints, brush : LinearBrush.defaultBrush(Colors.blueGrey))!;
  final smoothedStroke = smoother.smooth(stroke);

  group("Test the basic functionalities of Stroke class", () {

    test("Stroke.fromRawStrokePoints, stroke.rectInGlobalSpace test", () async {
      final rect = await stroke.rectInGlobalSpace;
      expect(rect.left, -1.45);
      expect(rect.top, -2.05);
      expect(rect.right, 5.25);
      expect(rect.bottom, 1.85);
    });

    test("stroke.color test", () {
      expect(stroke.color.r, Colors.blueGrey.r);
      expect(stroke.color.g, Colors.blueGrey.g);
      expect(stroke.color.b, Colors.blueGrey.b);
    });

    test("Chaikin smoother", () {
      expect(stroke.strokePoints.length < smoothedStroke.strokePoints.length, true);
    });

  });
}