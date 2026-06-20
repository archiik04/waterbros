import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationPermissionsScreen extends StatelessWidget {
  const NotificationPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Icon(
              Icons.notifications_active_outlined,
              size: 120,
              color: Color(0xFF06B6D4),
            ),
            const SizedBox(height: 32),
            Text(
              'Get Reminders to Stay Hydrated',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "We'll remind you to drink water at the right times based on your activity.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('ENABLE NOTIFICATIONS'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/home'),
              child: const Text('Maybe Later'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
