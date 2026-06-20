import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/challenges_provider.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(challengesProvider.notifier).fetchChallenges(),
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (state.active.isNotEmpty) ...[
                    Text(
                      'Your Active Challenges',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.active.length,
                      itemBuilder: (context, index) {
                        final challenge = state.active[index];
                        final ratio = (challenge.progress / challenge.goal).clamp(0.0, 1.0);
                        return Card(
                          child: ListTile(
                            onTap: () => context.push('/challenges/${challenge.id}'),
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFEFF6FF),
                              child: Icon(Icons.star, color: Color(0xFF2563EB)),
                            ),
                            title: Text(challenge.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: ratio,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  color: const Color(0xFF2563EB),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${challenge.progress} / ${challenge.goal} L • ${challenge.timeRemaining}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    'Available Challenges',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  if (state.available.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: Text('No available challenges.')),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.available.length,
                      itemBuilder: (context, index) {
                        final challenge = state.available[index];
                        return Card(
                          child: ListTile(
                            onTap: () => context.push('/challenges/${challenge.id}'),
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFECFDF5),
                              child: Icon(Icons.emoji_events, color: Color(0xFF10B981)),
                            ),
                            title: Text(challenge.title),
                            subtitle: Text('${challenge.participantsCount} participants • ${challenge.timeRemaining}'),
                            trailing: ElevatedButton(
                              onPressed: () => ref.read(challengesProvider.notifier).join(challenge.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('JOIN'),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
