import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scribby/data/container/grid_pos.dart';
import 'package:scribby/data/container/search_grid.dart';
import 'package:scribby/data/scribble/scribble_item.dart';

class MockScribbleItem extends ScribbleItem {
  final Rect _rect;
  
  MockScribbleItem(this._rect);
  
  @override
  Rect get rectInGlobalSpace => _rect;
}

void testGridPosFromGlobal() {
  final gridPos = GridPos.fromGlobalPos(Offset(15.0, -105.0), 10.0);
  expect(gridPos.x, 1);
  expect(gridPos.y, -11);
}

void testSearchIndicesByRect() {
  List<MockScribbleItem> scribbleItems = [
    MockScribbleItem(Rect.fromLTWH(100.0, 200.0, 150.0, 200.0)),
    MockScribbleItem(Rect.fromLTWH(-150.0, 200.0, 300.0, 150.0)),
    MockScribbleItem(Rect.fromLTWH(-200.0, -200.0, 180.0, 160.0)),
    MockScribbleItem(Rect.fromLTWH(300.0, -100.0, 120.0, 100.0)),
    MockScribbleItem(Rect.fromLTWH(100.0, 200.0, 500.0, 600.0)),
  ];

  Rect mockViewport = Rect.fromLTWH(200, 200, 100, 100);

  final grid = SearchGrid(scribbleItems);
  final indices = grid.searchIndicesOfItemsInRect(mockViewport);
  expect(indices, [0, 4]);
}

void main() {
  group("Test the basic searching functionalities of SearchGrid\n", () {

    test(
      "Test the GridPos.fromGlobalPos",
      () => testGridPosFromGlobal() 
    );

    test(
      "Test SearchGrid().searchIndicesOfItemsInRect.\nIn this test, only the first and the fifth items are in the viewport.", 
      () => testSearchIndicesByRect()
    );

  }); 
}