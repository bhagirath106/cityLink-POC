import 'package:flutter/material.dart';

class VoucherRibbon extends StatelessWidget {
  final String label;
  final Color color;
  final double width;

  const VoucherRibbon({
    super.key,
    required this.label,
    this.color = Colors.pink,
    this.width = 30,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: RibbonPainter(color: color, colorScheme: colorScheme),
      child: SizedBox(
        width: width,
        child: Center(
          child: RotatedBox(
            quarterTurns: -1,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RibbonPainter extends CustomPainter {
  final Color color;
  final ColorScheme colorScheme;
  RibbonPainter({required this.color, required this.colorScheme});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    final radius = 5.0;
    final spacing = 18.0;

    // Base rectangle with rounded top-left and bottom-left
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: const Radius.circular(10),
        bottomLeft: const Radius.circular(10),
      ),
    );

    canvas.drawPath(path, paint);

    // White cut-out circles
    final circlePaint = Paint()..color = colorScheme.onPrimaryContainer;

    for (double y = spacing; y < size.height - spacing; y += spacing) {
      canvas.drawCircle(Offset(0, y + 8), radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
