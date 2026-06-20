import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Responsive helper
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Centered custom-painted water droplet (Cute Character)
                  SizedBox(
                    width: 160,
                    height: 200,
                    child: CustomPaint(
                      painter: DropletPainter(),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 2. Headline: "Stay Hydrated"
                  Text(
                    'WaterBros',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 36 : 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 3. Subheadline
                  Text(
                    'Master your hydration habits with effortless tracking and real-time reminders.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 4. Feature Cards Row (TRACK, SYNC, RANK)
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          context: context,
                          icon: Icons.local_drink_rounded,
                          label: 'TRACK',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          context: context,
                          icon: Icons.sync_rounded,
                          label: 'SYNC',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          context: context,
                          icon: Icons.bar_chart_rounded,
                          label: 'RANK',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // 5. GET STARTED Button (Solid black, white bold text, fully rounded capsule style)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.white : Colors.black,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        elevation: 0,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 6. SIGN IN Button (gray, centered text link, all caps)
                  TextButton(
                    onPressed: () => context.go('/login'),
                    style: TextButton.styleFrom(
                      foregroundColor: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                    ),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 7. Footer: "By continuing, you agree to our Terms of Service." (small, muted, centered)
                  Text(
                    'By continuing, you agree to our Terms of Service.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular white shape enclosing the icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF334155) : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white : Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          // Uppercase bold label
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: isDark ? const Color(0xFFF1F5F9) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DropletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Soft Shadow Underneath the Character
    final shadowPaint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.93),
        width: w * 0.38,
        height: h * 0.04,
      ),
      shadowPaint,
    );

    // 2. Legs & Feet
    final limbPaint = Paint()
      ..color = const Color(0xFF1E293B) // Dark charcoal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final solidLimbPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    // Draw vertical stick legs
    canvas.drawLine(Offset(w * 0.46, h * 0.77), Offset(w * 0.46, h * 0.88), limbPaint);
    canvas.drawLine(Offset(w * 0.56, h * 0.77), Offset(w * 0.56, h * 0.88), limbPaint);

    // Draw horizontal feet pointing outward
    // Left foot (pointing left)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.40, h * 0.87, w * 0.07, h * 0.035),
        const Radius.circular(6),
      ),
      solidLimbPaint,
    );
    // Right foot (pointing right)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.55, h * 0.87, w * 0.07, h * 0.035),
        const Radius.circular(6),
      ),
      solidLimbPaint,
    );

    // 3. Waving Left Arm (Peace sign)
    final leftArmPath = Path();
    leftArmPath.moveTo(w * 0.26, h * 0.58);
    leftArmPath.quadraticBezierTo(
      w * 0.18, h * 0.55,
      w * 0.18, h * 0.45,
    );
    canvas.drawPath(leftArmPath, limbPaint);

    // Peace sign fingers
    // Finger 1 (pointing up-left)
    canvas.drawLine(Offset(w * 0.18, h * 0.45), Offset(w * 0.14, h * 0.38), limbPaint);
    // Finger 2 (pointing up-right)
    canvas.drawLine(Offset(w * 0.18, h * 0.45), Offset(w * 0.20, h * 0.38), limbPaint);

    // 4. Hanging Right Arm
    final rightArmPath = Path();
    rightArmPath.moveTo(w * 0.74, h * 0.61);
    rightArmPath.quadraticBezierTo(
      w * 0.80, h * 0.64,
      w * 0.81, h * 0.73,
    );
    canvas.drawPath(rightArmPath, limbPaint);

    // Solid circle hand
    canvas.drawCircle(Offset(w * 0.81, h * 0.73), 6, solidLimbPaint);

    // 5. Plump Light Blue Droplet Body Shape
    final bodyPath = Path();
    bodyPath.moveTo(w * 0.5, h * 0.08);

    // Right curve of droplet
    bodyPath.cubicTo(
      w * 0.88, h * 0.42,  // control 1
      w * 0.88, h * 0.78,   // control 2
      w * 0.5, h * 0.78,    // end point (bottom center)
    );

    // Left curve back to peak
    bodyPath.cubicTo(
      w * 0.12, h * 0.78,   // control 1
      w * 0.12, h * 0.42,  // control 2
      w * 0.5, h * 0.08,    // end point (peak)
    );
    bodyPath.close();

    final bodyPaint = Paint()
      ..color = const Color(0xFF8FD3FC) // Pastel sky blue
      ..style = PaintingStyle.fill;

    canvas.drawPath(bodyPath, bodyPaint);

    // 6. Two Tilted White Oval Highlights (Top-Left of Droplet)
    // Highlight 1 (Larger oval tilted)
    canvas.save();
    canvas.translate(w * 0.44, h * 0.22);
    canvas.rotate(-math.pi / 6); // Tilted counter-clockwise
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0, 0), width: w * 0.05, height: h * 0.11),
      highlightPaint,
    );
    canvas.restore();

    // Highlight 2 (Smaller circle/oval below highlight 1)
    canvas.drawCircle(
      Offset(w * 0.38, h * 0.29),
      w * 0.03,
      highlightPaint,
    );

    // 7. Rosy Cheeks
    final cheekPaint = Paint()
      ..color = const Color(0xFFFDA4AF) // Rose pink blush
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.34, h * 0.58), width: w * 0.09, height: h * 0.04),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.66, h * 0.58), width: w * 0.09, height: h * 0.04),
      cheekPaint,
    );

    // 8. Eyes (Large black circles with dual reflection dots)
    final double leftEyeX = w * 0.42;
    final double rightEyeX = w * 0.58;
    final double eyeY = h * 0.52;
    final double eyeRadius = w * 0.05;

    final eyePaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    // Draw eye bases
    canvas.drawCircle(Offset(leftEyeX, eyeY), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(rightEyeX, eyeY), eyeRadius, eyePaint);

    // Dual reflections
    final reflectionPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Left eye reflections
    canvas.drawCircle(Offset(leftEyeX - w * 0.015, eyeY - h * 0.012), w * 0.018, reflectionPaint);
    canvas.drawCircle(Offset(leftEyeX + w * 0.012, eyeY + h * 0.010), w * 0.009, reflectionPaint);

    // Right eye reflections
    canvas.drawCircle(Offset(rightEyeX - w * 0.015, eyeY - h * 0.012), w * 0.018, reflectionPaint);
    canvas.drawCircle(Offset(rightEyeX + w * 0.012, eyeY + h * 0.010), w * 0.009, reflectionPaint);

    // 9. Happy Open Mouth with Pink Tongue
    final mouthBackgroundPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    final mouthPath = Path();
    mouthPath.moveTo(w * 0.46, h * 0.54);
    // Draw outer curved mouth cavity
    mouthPath.quadraticBezierTo(w * 0.50, h * 0.59, w * 0.54, h * 0.54);
    // Close with a slight upper curve
    mouthPath.quadraticBezierTo(w * 0.50, h * 0.56, w * 0.46, h * 0.54);
    mouthPath.close();

    canvas.drawPath(mouthPath, mouthBackgroundPaint);

    // Clip tongue inside the mouth cavity
    canvas.save();
    canvas.clipPath(mouthPath);
    final tonguePaint = Paint()
      ..color = const Color(0xFFFCA5A5) // Soft pink tongue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.50, h * 0.58), w * 0.03, tonguePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
