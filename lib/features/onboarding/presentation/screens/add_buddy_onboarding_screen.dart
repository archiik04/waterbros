import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddBuddyOnboardingScreen extends StatelessWidget {
  const AddBuddyOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Buddies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.people_outline,
              size: 96,
              color: Color(0xFF2563EB),
            ),
            const SizedBox(height: 24),
            Text(
              'Add Your First Buddy',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Invite a friend to stay accountable. Optional, you can add buddies anytime.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search by username',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Buddy request sent to $value!')),
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/notification-permissions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('CONTINUE'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/notification-permissions'),
              child: const Text("I'll add friends later"),
            ),
          ],
        ),
      ),
    );
  }
}
