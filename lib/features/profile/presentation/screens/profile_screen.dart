import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repositories/profile_repository.dart';
import '../providers/profile_provider.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);

    if (state.isLoading || state.profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final profile = state.profile!;
    final xpPercent = (profile.currentXp / profile.maxXp).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person, size: 48, color: Colors.grey),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFF2563EB),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                        onPressed: () => _showEditProfileModal(context, ref, profile),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              profile.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '@${profile.username} • ${profile.pronouns}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              profile.bio,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Level Stats Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LEVEL ${profile.level}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '${profile.currentXp}/${profile.maxXp} XP',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: xpPercent,
                      backgroundColor: const Color(0xFFE2E8F0),
                      color: const Color(0xFF2563EB),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${profile.maxXp - profile.currentXp} XP to go for level up!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid Stats
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(context, 'Weekly Intake', '${profile.weeklyWaterLiters}L', Icons.water_drop),
                _buildStatCard(context, 'Longest Streak', '${profile.longestStreak} days', Icons.local_fire_department),
              ],
            ),
            const SizedBox(height: 24),

            // Achievements List
            Text(
              'Achievements (${profile.achievements.length})',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.achievements.length,
              itemBuilder: (context, index) {
                final achievement = profile.achievements[index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFEF3C7),
                      child: Icon(Icons.emoji_events, color: Color(0xFFD97706)),
                    ),
                    title: Text(achievement),
                    subtitle: const Text('Unlocked!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF06B6D4)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context, WidgetRef ref, UserProfile profile) {
    final nameController = TextEditingController(text: profile.name);
    final bioController = TextEditingController(text: profile.bio);
    final pronounsController = TextEditingController(text: profile.pronouns);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Display Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pronounsController,
                decoration: const InputDecoration(labelText: 'Pronouns', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(profileProvider.notifier).updateProfile(
                        name: nameController.text.trim(),
                        bio: bioController.text.trim(),
                        pronouns: pronounsController.text.trim(),
                      );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SAVE CHANGES'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
