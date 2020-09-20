import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: CurvedLineWidget(),
          ),
        ),
      ),
    );
  }
}

class CurvedLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvedLineCustomPainter(20),
      size: Size(double.infinity, 100),
    );
  }

}


class _CurvedLineCustomPainter extends CustomPainter {

  final double curveHeight;

  Paint linePaint = Paint()
    ..color = Colors.lightBlueAccent
    ..style = PaintingStyle.stroke..strokeWidth = 8
    ..strokeCap = StrokeCap.round;

  _CurvedLineCustomPainter(this.curveHeight);

  @override
  void paint(Canvas canvas, Size size) {

    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width , size.height / 2);
    final controlPoint = Offset((point2.dx - point1.dx) / 2, (size.height / 2) - (curveHeight * 2));

    Path path = new Path();
    path.moveTo(point1.dx, point1.dy);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, point2.dx, point2.dy);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
