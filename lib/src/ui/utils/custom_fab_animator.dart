import 'dart:math';

import 'package:flutter/material.dart';

class CustomFabAnimator extends FloatingActionButtonAnimator {
  const CustomFabAnimator();

  @override
  Offset getOffset({
    required Offset begin,
    required Offset end,
    required double progress,
  }) {
    return end;
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return CurvedAnimation(
      parent: Tween<double>(begin: 1.0, end: 1.0).animate(parent),
      curve: Curves.bounceInOut,
    );
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  double getAnimationRestart(double previousValue) =>
      min(1.0 - previousValue, previousValue);
}
