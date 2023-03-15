import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/paints/base_painter.dart';
import 'package:flutter_sample/paints/slider_paint.dart';

class CircularSliderPaint extends StatefulWidget {
  final int init;
  final int end;
  final int intervals;
  final Function onSelectionChange;
  final Color baseColor;
  final Color selectionColor;
  final Widget? child;

  CircularSliderPaint(
      {required this.intervals,
        required this.init,
        required this.end,
        this.child,
        required this.onSelectionChange,
        required this.baseColor,
        required this.selectionColor});

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSliderPaint> {
  bool _isInitHandlerSelected = false;
  bool _isEndHandlerSelected = false;

  late SliderPainter _painter;

  /// start angle in radians where we need to locate the init handler
  late double _startAngle;

  /// end angle in radians where we need to locate the end handler
  late double _endAngle;

  /// the absolute angle in radians representing the selection
  late double _sweepAngle;

  @override
  void initState() {
    super.initState();
    _calculatePaintData();
  }

  // we need to update this widget both with gesture detector but
  // also when the parent widget rebuilds itself
  @override
  void didUpdateWidget(CircularSliderPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.init != widget.init || oldWidget.end != widget.end) {
      _calculatePaintData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(42.0),
      child: GestureDetector(
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: CustomPaint(
          painter: BasePainter(
              baseColor: widget.baseColor,
              selectionColor: widget.selectionColor),
          foregroundPainter: _painter,
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _calculatePaintData() {
    double initPercent = valueToPercentage(widget.init, widget.intervals);
    double endPercent = valueToPercentage(widget.end, widget.intervals);
    double sweep = getSweepAngle(initPercent, endPercent);

    _startAngle = percentageToRadians(initPercent);
    _endAngle = percentageToRadians(endPercent);
    _sweepAngle = percentageToRadians(sweep.abs());

    _painter = SliderPainter(
      startAngle: _startAngle,
      endAngle: _endAngle,
      sweepAngle: _sweepAngle,
      selectionColor: widget.selectionColor,
    );
  }

  _onPanUpdate(DragUpdateDetails details) {
    // if (!_isInitHandlerSelected && !_isEndHandlerSelected) {
    //   print('on pan update called');
    //
    //   return;
    // }
    if (_painter.center == null) {

      return;
    }
    RenderBox? renderBox = this.context.findRenderObject() as RenderBox?;
    var position = renderBox!.globalToLocal(details.globalPosition);

    var angle = coordinatesToRadians(_painter.center!, position);
    var percentage = radiansToPercentage(angle);
    var newValue = percentageToValue(percentage, widget.intervals);
    print('percentage ${percentage}');

    if (_isInitHandlerSelected) {
      widget.onSelectionChange(newValue, widget.end);
    } else {
      print('percentage2 ${newValue}');

      widget.onSelectionChange(widget.init, newValue);
    }

  }

  _onPanEnd(_) {
    _isInitHandlerSelected = false;
    _isEndHandlerSelected = false;
  }

  _onPanDown(DragDownDetails details) {
    if (_painter == null) {
      return;
    }
    RenderBox? renderBox = this.context.findRenderObject() as RenderBox?;
    var position = renderBox!.globalToLocal(details.globalPosition);
    if (position != null) {
      _isInitHandlerSelected = isPointInsideCircle(
          position, _painter.initHandler!, 12.0);
      if (!_isInitHandlerSelected) {
        _isEndHandlerSelected = isPointInsideCircle(
            position, _painter.endHandler!, 12.0);
      }
    }

  }
}


double valueToPercentage(int time, int intervals) => (time / intervals) * 100;


double getSweepAngle(double init, double end) {
  if (end > init) {
    return end - init;
  }
  return (100 - init + end).abs();
}

double percentageToRadians(double percentage) => ((2 * pi * percentage) / 100);

bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  var radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}


double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return atan2(b, a);
}


double radiansToPercentage(double radians) {
  var normalized = radians < 0 ? -radians : 2 * pi - radians;
  var percentage = ((100 * normalized) / (2 * pi));
  return (percentage + 25) % 100;
}

int percentageToValue(double percentage, int intervals) =>
    ((percentage * intervals) / 100).round();
