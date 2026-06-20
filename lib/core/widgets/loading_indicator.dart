import 'package:flutter/material.dart';

class WaterBrosLoadingIndicator extends StatelessWidget {
  final String? message;

  const WaterBrosLoadingIndicator({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF06B6D4), // Water Cyan from PRD
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B), // Neutral Gray from PRD
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
