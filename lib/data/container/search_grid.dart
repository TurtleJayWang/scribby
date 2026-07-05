import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:scribby/data/container/grid_pos.dart';
import 'package:scribby/data/container/grid_rect.dart';
import 'package:scribby/data/scribble/scribble_content.dart';

/// This SearchGrid is design for fast searching of items in 
/// a Scribble, users can search for items using Rect in global
/// space or GridPos in a SearchGrid.
/// 
/// Common usages:
/// 1. Search for items being in the viewport
/// 2. Check intersection
/// 
/// If the index of an item is N, the item is the Nth item added to the SearchGrid.
/// 
/// Example:
/// ```
/// final stroke1 = Stroke(strokePoints1);
/// final stroke2 = Stroke(strokePoints2);
/// final camera = Camera(viewportRect);
/// 
/// final strokesSearchGrid = SearchGrid([stroke1, stroke2]);
/// final strokesInCamera = strokesSearchGrid.searchItemsInRect(camera.viewportRect);
/// paint(strokesInCamera);
/// ```
class SearchGrid<T extends ScribbleContent> {
  final HashMap< GridPos, List<_GridItem<T>> > _gridPosToItemsMap = HashMap();
  final List<T> _itemsList = [];
  final double _gridSize;

  SearchGrid._([this._gridSize = 10.0]);

  static Future<SearchGrid<sT>> createSearchGrid<sT extends ScribbleContent>(
    List<sT> items, { double gridSize = 10.0 }
  ) async {
    final grid = SearchGrid<sT>._(gridSize);
    await grid.addAll(items);
    return grid;
  }

  Future<void> add(T item) async {
    await _addItemToMapWithIndex(item, _itemsList.length);
    _addItemToList(item);
  }

  Future<void> addAll(List<T> items) async {
    for (final item in items) {
      await add(item);
    }
  }

  T operator [](int i) => _itemsList[i];

  List<T> toList() => _itemsList;

  List<int> searchIndicesOfItemsInRect(Rect rect) {
    SplayTreeSet<int> indices = SplayTreeSet();

    final gridRect = GridRect.fromRectAndGridSize(rect, _gridSize);
    final gridPositions = gridRect.getGridPositionsInRect();

    for (final pos in gridPositions) {
      indices.addAll(
        indicesOfItemsInGridPos(pos).where((i) => _itemsList[i].rectInGlobalSpaceSync.overlaps(rect))
      );
    }

    return indices.toList();
  }

  List<T> searchItemsInRect(Rect rect) {
    final indicesOfItems = searchIndicesOfItemsInRect(rect);
    return indicesOfItems.map((i) => _itemsList[i]).toList();
  }

  List<int> indicesOfItemsInGridPos(GridPos pos) {
    SplayTreeSet<int> indices = SplayTreeSet();
    for (final gridItem in _gridPosToItemsMap[pos] ?? <_GridItem<T>>[]) {
      indices.add(gridItem.index);
    }
    return indices.toList();
  }

  List<T> itemsInGridPos(GridPos pos) {
    final indicesOfItems = indicesOfItemsInGridPos(pos);
    return indicesOfItems.map((i) => _itemsList[i]).toList();    
  }

  Future<void> _addItemToMapWithIndex(T item, int index) async {
    final gridRect = GridRect.fromRectAndGridSize(await item.rectInGlobalSpace, _gridSize);
    final gridPositions = gridRect.getGridPositionsInRect();
    
    for (final pos in gridPositions) {
      _gridPosToItemsMap[pos] ??= [];
      _gridPosToItemsMap[pos]!.add(_GridItem(index, item));
    }
  }

  void _addItemToList(T item) => _itemsList.add(item); 
}

class _GridItem<T> {
  final int index;
  final T item;
  const _GridItem(this.index, this.item);
}