import 'dart:math' as math;
import 'package:flutter/material.dart';

num degToRad(num deg) => deg * (math.pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / math.pi);

double mapValueFromRangeToRange(double value, double fromLow, double fromHigh,
    double toLow, double toHigh) {
  return toLow + ((value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow));
}

double clamp(double value, double low, double high) {
  return math.min(math.max(value, low), high);
}

Widget defaultWidgetBuilder(bool isFavorite, double size) {
  return Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
    color: Colors.pinkAccent,
    size: size,
  );
}

/// Definitions
typedef FavoriteButtonTapCallback = Future<bool> Function(bool isFavorite);

///build widget when isLike is changing
typedef FavoriteWidgetBuilder = Widget? Function(bool isFavorite);
