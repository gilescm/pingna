import 'package:flutter/material.dart';
import 'package:pingna/resources/assets.dart';

class PostBoxShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      child: CustomPaint(
        painter: _MyPainter(),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = primaryColor;

    Offset topLeft = Offset(0, size.height * 0.5);
    Offset bottomLeft = Offset(0, size.height);
    Offset topRight = Offset(size.width, size.height * 0.4);
    Offset bottomRight = Offset(size.width, size.height);

    Path path = Path()
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..cubicTo(
        size.width,
        0,
        size.width * 0.6,
        size.height * 0.5,
        size.width * 0.55,
        -size.height * 0.05,
      )
      ..cubicTo(
        size.width * 0.5,
        -size.height * 0.4,
        size.width * 0.2,
        -size.height * 0.3,
        size.width * 0.2,
        size.height * 0.1,
      )
      ..cubicTo(
        size.width * 0.195,
        size.height * 0.25,
        size.width * 0.25,
        size.height * 0.6,
        topLeft.dx,
        topLeft.dy,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
