import 'dart:math';

import 'package:flutter/material.dart';

class ConvexCircularNotch extends CircularNotchedRectangle {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final double notchRadius = guest.width / 2.0;

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    /// Remove the 10s from below to revert to original
    final double n2 = sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b) + 10;
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b) + 10;
    final double p2yA = sqrt(r * r - p2xA * p2xA) - 10;
    final double p2yB = sqrt(r * r - p2xB * p2xB) - 10;

    final List<Offset?> p = List<Offset?>.filled(6, null, growable: false);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = -Offset(a - s1, b);
    p[1] = -Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = -(cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB));

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] = p[i]! + guest.center;

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}