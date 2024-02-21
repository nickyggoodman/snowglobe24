import 'package:flutter/material.dart';

class GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double length = size.shortestSide;
    Path triangle = Path()
      ..moveTo(0.05 * length, 0.95 * length)
      ..lineTo(length / 2.0, length / 2.0)
      ..lineTo(0.95 * length, 0.95 * length)
      ..close();
    Path circle = Path()
      ..addOval(Rect.fromCenter(
          center: Offset(length / 2.0, length / 2.0),
          width: 0.75 * length,
          height: 0.75 * length));
    canvas.drawPath(triangle, Paint()..color = Colors.green);
    canvas.drawPath(
        circle,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.black
          ..strokeWidth = 10.0);
    canvas.clipPath(circle);
    canvas.drawRect(Rect.largest, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
