import 'dart:math';

import 'package:flutter/material.dart';

class BasePainter extends CustomPainter {
  Color baseColor;

  Offset? center;
  double? radius;
  Path path = Path();


  BasePainter({required this.baseColor, required Color selectionColor});

  Paint paint1 = Paint()
    ..color = Colors.grey.shade200
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = baseColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2);
    var radius2 = min(size.width / 2.1, size.height / 2.1);

    canvas.drawCircle(center!, radius!, paint);
    canvas.drawCircle(center!, radius2, paint1);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}