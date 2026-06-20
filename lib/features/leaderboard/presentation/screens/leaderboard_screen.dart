import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/leaderboard_provider.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leaderboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Friends')),
                    selected: state.selectedTab == 'friends',
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(leaderboardProvider.notifier).fetchRankings('friends');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Global')),
                    selected: state.selectedTab == 'global',
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(leaderboardProvider.notifier).fetchRankings('global');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => ref.read(leaderboardProvider.notifier).fetchRankings(state.selectedTab),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: state.entries.length,
                      itemBuilder: (context, index) {
                        final entry = state.entries[index];
                        final scoreStr = entry.scoreUnit == 'ml'
                            ? '${(entry.score / 1000).toStringAsFixed(1)}L'
                            : '${entry.score.toStringAsFixed(0)} XP';
                        return Card(
                          color: entry.isCurrentUser
                              ? const Color(0xFFEFF6FF) // Muted blue highlight
                              : null,
                          child: ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    '${entry.rank}.',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xFFE2E8F0),
                                  child: Icon(Icons.person, size: 16),
                                ),
                              ],
                            ),
                            title: Text(
                              entry.name,
                              style: TextStyle(
                                fontWeight: entry.isCurrentUser ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text('@${entry.username}'),
                            trailing: Text(
                              scoreStr,
                              style: const TextStyle(
                                fontFamily: 'Courier New',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
