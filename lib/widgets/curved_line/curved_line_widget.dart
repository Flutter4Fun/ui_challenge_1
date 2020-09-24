import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvedLineWidget extends StatelessWidget {
  final double curveHeight, lineThickness, gradientHeight;
  final Color lineColor;
  final List<Color> gradientColors;

  const CurvedLineWidget({
    Key key,
    double curveHeight,
    double lineThickness,
    double gradientHeight,
    Color lineColor,
    List<Color> gradientColors,
  })  : curveHeight = curveHeight ?? 20,
        lineThickness = lineThickness ?? 8,
        gradientHeight = gradientHeight ?? 68,
        lineColor = lineColor ?? Colors.lightBlueAccent,
        gradientColors = gradientColors ?? const [Color(0x6600B0FF), Color(0x0000B0FF)],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvedLineCustomPainter(
        curveHeight,
        lineThickness,
        gradientHeight,
        lineColor,
        gradientColors,
      ),
      size: Size(double.infinity, gradientHeight),
    );
  }
}

class _CurvedLineCustomPainter extends CustomPainter {
  final double curveHeight;
  final double lineThickness;
  final double gradientHeight;
  final Color lineColor;
  final List<Color> gradientColors;

  Paint linePaint, glowAreaPaint;

  _CurvedLineCustomPainter(
    this.curveHeight,
    this.lineThickness,
    this.gradientHeight,
    this.lineColor,
    this.gradientColors,
  ) {
    linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineThickness
      ..strokeCap = StrokeCap.round;

    glowAreaPaint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final point1 = Offset((lineThickness / 2), curveHeight);
    final point2 = Offset(size.width - (lineThickness / 2), curveHeight);
    final controlPoint =
        Offset((point2.dx - point1.dx) / 2, point1.dy - (curveHeight * 2) + lineThickness);

    Path linePath = new Path();
    linePath.moveTo(point1.dx, point1.dy);
    linePath.quadraticBezierTo(controlPoint.dx, controlPoint.dy, point2.dx, point2.dy);

    Path glowAreaPath = Path.from(linePath);
    glowAreaPath.lineTo(point2.dx, point2.dy + gradientHeight);
    glowAreaPath.lineTo(point1.dx, point1.dy + gradientHeight);
    glowAreaPath.lineTo(point1.dx, point1.dy); // step3

    glowAreaPaint
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, gradientHeight),
        gradientColors,
      );

    canvas.drawPath(glowAreaPath, glowAreaPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
