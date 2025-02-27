import 'package:flutter/material.dart';

class RightAngleTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange // Triangle color
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.height, 0);
    path.lineTo(size.width, size.height*0.88); // Bottom-right corner
    path.lineTo(0, 0); // Top-left corner
    path.close(); // Complete the triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}