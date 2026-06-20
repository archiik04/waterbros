import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final String label;
  final String provider; // 'google' or 'apple'
  final VoidCallback onPressed;

  const SocialAuthButton({
    super.key,
    required this.label,
    required this.provider,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Select appropriate colors
    final backgroundColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    final textColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(context, backgroundColor),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, Color backgroundColor) {
    if (provider == 'google') {
      return SizedBox(
        width: 18,
        height: 18,
        child: CustomPaint(
          painter: _GoogleLogoPainter(backgroundColor: backgroundColor),
        ),
      );
    } else {
      return Icon(
        Icons.apple,
        size: 20,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      );
    }
  }
}

class _GoogleLogoPainter extends CustomPainter {
  final Color backgroundColor;

  _GoogleLogoPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;
    final rect = Rect.fromLTWH(0, 0, width, height);
    
    // Top Red
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -2.35, 1.5, true, paint);

    // Left Yellow
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -3.85, 1.5, true, paint);

    // Bottom Green
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.85, 1.5, true, paint);

    // Right Blue
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -0.85, 1.7, true, paint);

    // Cutout center using the button's background color
    paint.color = backgroundColor;
    canvas.drawCircle(Offset(width / 2, height / 2), width * 0.28, paint);

    // Draw the horizontal bar of the 'G'
    paint.color = const Color(0xFF4285F4);
    final barRect = Rect.fromLTWH(width * 0.5, height * 0.42, width * 0.45, height * 0.16);
    canvas.drawRect(barRect, paint);
  }

  @override
  bool shouldRepaint(covariant _GoogleLogoPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor;
}
