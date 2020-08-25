import 'package:flutter/material.dart';

class DashDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashDividerPainter(),
    );
  }
}

class DashDividerPainter extends CustomPainter {
  final Color color;
  final double thikness;

  DashDividerPainter({
    this.color = const Color(0xFF969696),
    this.thikness = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = thikness
      ..style = PaintingStyle.stroke;

    var path = Path();
    bool shoodDraw = true;
    var x = thikness;
    const y = -4.0;
    path.moveTo(x, y);
    while (x < size.width - thikness) {
      if (shoodDraw) {
        path.lineTo(x + thikness, y);
      } else {
        path.moveTo(x + thikness, y);
      }
      shoodDraw = !shoodDraw;
      x = x + thikness;
    }

    canvas.drawPath(path, dashedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
