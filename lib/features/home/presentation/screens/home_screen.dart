import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/helpers.dart';
import '../providers/hydration_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hydrationState = ref.watch(hydrationProvider);
    final percentage = (hydrationState.currentMl / hydrationState.goalMl).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WaterBros'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2563EB)),
              child: Text(
                'WaterBros Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                context.push('/settings');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick Stats Card (Hero Section)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value: percentage,
                            strokeWidth: 12,
                            backgroundColor: const Color(0xFFE2E8F0),
                            color: const Color(0xFF06B6D4), // Water Cyan
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Helpers.formatLiters(hydrationState.currentMl / 1000),
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
                            ),
                            Text(
                              'of ${Helpers.formatLiters(hydrationState.goalMl / 1000)} today',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      percentage >= 0.75
                          ? "Great job! You're on track"
                          : percentage >= 0.5
                              ? "You're halfway there! Keep going"
                              : "Don't forget to hydrate",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Quick log grid/buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => ref.read(hydrationProvider.notifier).logWater(250),
                    icon: const Icon(Icons.local_drink),
                    label: const Text('+250ml'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => ref.read(hydrationProvider.notifier).logWater(500),
                    icon: const Icon(Icons.water_drop),
                    label: const Text('+500ml'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Today's Logs card
            Text(
              "Today's Logs",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            if (hydrationState.todayLogs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text('No water logged yet today.', textAlign: TextAlign.center),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hydrationState.todayLogs.length,
                itemBuilder: (context, index) {
                  final log = hydrationState.todayLogs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.water_drop, color: Color(0xFF06B6D4)),
                      title: Text(Helpers.formatMl(log.amountMl)),
                      subtitle: Text(Helpers.formatTimeOfDay(log.time)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => ref.read(hydrationProvider.notifier).deleteLog(log.id),
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
