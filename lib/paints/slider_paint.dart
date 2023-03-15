import 'dart:math';
import 'package:flutter/material.dart';


class SliderPainter extends CustomPainter {
  double startAngle;
  double endAngle;
  double sweepAngle;
  Color selectionColor;

  Offset? initHandler;
  Offset? endHandler;
  Offset? center;
  double? radius;


  SliderPainter(
      {required this.startAngle,
        required this.endAngle,
        required this.sweepAngle,
        required this.selectionColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (startAngle == 0.0 && endAngle == 0.0) return;

    Paint progress = _getPaint(color: selectionColor);

    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: center!, radius: radius!),
        -pi / 2 + startAngle, sweepAngle, false, progress);

    Paint handler = _getPaint(color: selectionColor, style: PaintingStyle.fill);
    Paint handlerOutter = _getPaint(color: selectionColor, width: 2.0);

    // draw handlers
    initHandler = radiansToCoordinates(center!, -pi / 2 + startAngle, radius!);
    //use if need 2 points in seekbar
    // canvas.drawCircle(initHandler!, 8.0, handler);
    // canvas.drawCircle(initHandler!, 12.0, handlerOutter);

    endHandler = radiansToCoordinates(center!, -pi / 2 + endAngle, radius!);
    canvas.drawCircle(endHandler!, 8.0, handler);
    canvas.drawCircle(endHandler!, 12.0, handlerOutter);

  }

  Paint _getPaint({required Color color,  double? width,  PaintingStyle? style}) =>
      Paint()
        ..color = color
        ..strokeCap = StrokeCap.round
        ..style = style ?? PaintingStyle.stroke
        ..strokeWidth = width ?? 6.0;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Offset radiansToCoordinates(Offset center, double radians, double radius) {
    var dx = center.dx + radius * cos(radians);
    var dy = center.dy + radius * sin(radians);
    return Offset(dx, dy);
  }
}