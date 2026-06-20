import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/repositories/buddies_repository.dart';
import '../providers/buddies_provider.dart';

class BuddyDetailScreen extends ConsumerWidget {
  final String buddyId;

  const BuddyDetailScreen({
    super.key,
    required this.buddyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buddiesProvider);
    final buddy = state.buddies.firstWhere(
      (element) => element.id == buddyId,
      orElse: () => Buddy(
        id: buddyId,
        name: 'Unknown Buddy',
        username: 'unknown',
        currentMl: 0,
        goalMl: 2000,
        streakDays: 0,
        status: 'Unknown',
      ),
    );

    final ratio = (buddy.currentMl / buddy.goalMl).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(buddy.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFFE2E8F0),
                child: Icon(Icons.person, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              buddy.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '@${buddy.username}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('Streak', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('${buddy.streakDays} Days 🔥', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const VerticalDivider(width: 1, thickness: 1),
                    Column(
                      children: [
                        const Text('Hydration Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          '${Helpers.formatLiters(buddy.currentMl / 1000)} / ${Helpers.formatLiters(buddy.goalMl / 1000)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Today's Progress Indicator",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      value: ratio,
                      strokeWidth: 8,
                      backgroundColor: const Color(0xFFE2E8F0),
                      color: const Color(0xFF06B6D4),
                    ),
                  ),
                  Text(
                    '${(ratio * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Nudged ${buddy.name}! 💧')),
                      );
                    },
                    icon: const Icon(Icons.notifications_active),
                    label: const Text('NUDGE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sent reactions! 👍')),
                      );
                    },
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    label: const Text('REACT'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
