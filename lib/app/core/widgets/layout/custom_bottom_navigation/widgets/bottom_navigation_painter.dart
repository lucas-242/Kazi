import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/settings/app_colors.dart';

class BottomNavigationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final Path path = Path()..moveTo(0, 20);
    path.lineTo(size.width * 0.435, 20);
    path.quadraticBezierTo(size.width * 0.5, -5.5, size.width * 0.565, 20);
    path.lineTo(size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, AppColors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}