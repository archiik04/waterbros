import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/helpers.dart';
import '../providers/buddies_provider.dart';

class BuddyListScreen extends ConsumerWidget {
  const BuddyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buddiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Buddies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showAddBuddyModal(context, ref),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(buddiesProvider.notifier).fetchBuddies(),
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (state.requests.isNotEmpty) ...[
                    Text(
                      'Pending Requests (${state.requests.length})',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.requests.length,
                      itemBuilder: (context, index) {
                        final req = state.requests[index];
                        return Card(
                          color: const Color(0xFFF8FAFC),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE2E8F0),
                              child: Icon(Icons.person),
                            ),
                            title: Text(req.name),
                            subtitle: Text('@${req.username}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check, color: Colors.green),
                                  onPressed: () => ref.read(buddiesProvider.notifier).acceptRequest(req.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: () => ref.read(buddiesProvider.notifier).declineRequest(req.id),
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
                    'Active Buddies',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  if (state.buddies.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: Text('No buddies added yet.')),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.buddies.length,
                      itemBuilder: (context, index) {
                        final buddy = state.buddies[index];
                        final ratio = (buddy.currentMl / buddy.goalMl).clamp(0.0, 1.0);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            onTap: () => context.push('/buddies/${buddy.id}'),
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE2E8F0),
                              child: Icon(Icons.person),
                            ),
                            title: Text(buddy.name),
                            subtitle: Text('${Helpers.formatLiters(buddy.currentMl / 1000)} of ${Helpers.formatLiters(buddy.goalMl / 1000)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${buddy.streakDays} 🔥'),
                                const SizedBox(width: 12),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    value: ratio,
                                    strokeWidth: 3,
                                    backgroundColor: const Color(0xFFE2E8F0),
                                    color: const Color(0xFF06B6D4),
                                  ),
                                ),
                              ],
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

  void _showAddBuddyModal(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
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
                'Add Buddy',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    ref.read(buddiesProvider.notifier).sendRequest(text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Buddy request sent to @$text!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SEND REQUEST'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
