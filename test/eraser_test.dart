import 'package:flutter_test/flutter_test.dart';
import 'package:scribby/data/scribble/stroke/eraser/round_eraser.dart';
import 'package:scribby/data/scribble/stroke/eraser/square_eraser.dart';
import 'package:scribby/data/scribble/stroke/stroke_point.dart';

void main() {
  StrokePoint testPoint = StrokePoint(Offset.zero, 4.0);
  group("Eraser test", () {
    
    test("Round Eraser:", () {
      final eraser1 = RoundEraser(Offset(3.0, 0.0), 2.0);
      final eraser2 = RoundEraser(Offset(3.0, 3.0), 1.0);
      expect(eraser1.shouldErase(testPoint), true);
      expect(eraser2.shouldErase(testPoint), false);
    });

    test("Square eraser:", () {
      final eraser1 = SquareEraser(Offset(3.0, 3.0), 4.0);
      final eraser2 = SquareEraser(Offset(4.0, 0.0), 2.0);
      expect(eraser1.shouldErase(testPoint), true);
      expect(eraser2.shouldErase(testPoint), false);
    });

  });
}