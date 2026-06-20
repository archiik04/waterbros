import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/challenges_repository.dart';
import '../providers/challenges_provider.dart';

class ChallengeDetailScreen extends ConsumerWidget {
  final String challengeId;

  const ChallengeDetailScreen({
    super.key,
    required this.challengeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengesProvider);
    final challenge = [...state.active, ...state.available].firstWhere(
      (element) => element.id == challengeId,
      orElse: () => Challenge(
        id: challengeId,
        title: 'Unknown Challenge',
        description: '',
        timeRemaining: '',
        progress: 0,
        goal: 0,
        participantsCount: 0,
        isJoined: false,
        type: 'VOLUME',
      ),
    );

    final ratio = challenge.goal > 0 ? (challenge.progress / challenge.goal).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: challenge.isJoined ? const Color(0xFFEFF6FF) : const Color(0xFFECFDF5),
                child: Icon(
                  challenge.isJoined ? Icons.star : Icons.emoji_events,
                  size: 48,
                  color: challenge.isJoined ? const Color(0xFF2563EB) : const Color(0xFF10B981),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              challenge.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '${challenge.participantsCount} participants competing',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goal & Description',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(challenge.description),
                    const SizedBox(height: 16),
                    Text(
                      'Time Remaining',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(challenge.timeRemaining),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (challenge.isJoined) ...[
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${challenge.progress} L logged'),
                          Text('${challenge.goal} L goal'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: ratio,
                        minHeight: 12,
                        backgroundColor: const Color(0xFFE2E8F0),
                        color: const Color(0xFF2563EB),
                      ),
                      const SizedBox(height: 8),
                      Text('${(ratio * 100).toStringAsFixed(0)}% Completed'),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
            if (challenge.isJoined)
              OutlinedButton(
                onPressed: () {
                  ref.read(challengesProvider.notifier).leave(challenge.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You've left the challenge")),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('LEAVE CHALLENGE'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  ref.read(challengesProvider.notifier).join(challenge.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Welcome! Start logging water to earn points.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('JOIN CHALLENGE'),
              ),
          ],
        ),
      ),
    );
  }
}
