import 'package:flutter/material.dart';

abstract class ScribbleContent {
  Future<Rect> get rectInGlobalSpace;
  Rect get rectInGlobalSpaceSync;
}