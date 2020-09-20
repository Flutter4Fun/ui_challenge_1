
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvedLineWidget extends StatefulWidget {

  @override
  _CurvedLineWidgetState createState() => _CurvedLineWidgetState();
}

class _CurvedLineWidgetState extends State<CurvedLineWidget> {
  Offset touchedPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(
        painter: _CurvedLineCustomPainter(touchedPoint),
        size: Size(double.infinity, 100),
      ),
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          touchedPoint = details.localPosition;
        });
      },
    );
  }
}

class _CurvedLineCustomPainter extends CustomPainter {

  final Offset touchedPoint;

  Paint linePaint = Paint()..color = Colors.lightBlueAccent..style = PaintingStyle.stroke..strokeWidth = 8;

  _CurvedLineCustomPainter(this.touchedPoint);

  @override
  void paint(Canvas canvas, Size size) {

    final point1 = Offset(0, 80);
    final point2 = Offset(size.width , 80);
    final controlPoint = touchedPoint;

    Path path = new Path();
    path.moveTo(point1.dx, point1.dy);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, point2.dx, point2.dy);

    canvas.drawPath(path, linePaint);

    canvas.drawCircle(point1, 8, Paint()..color = Colors.purple);
    canvas.drawCircle(point2, 8, Paint()..color = Colors.green);
    canvas.drawCircle(controlPoint, 8, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
