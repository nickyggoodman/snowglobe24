import 'dart:math';
import 'package:flutter/material.dart';

class SquareClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    double length = min(size.width, size.height);
    return Rect.fromCenter(
        center: Offset(length / 2.0, length / 2.0),
        width: length * 0.75,
        height: length * 0.75);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
