import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/leaderboard_repository_impl.dart';
import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardState {
  final List<LeaderboardEntry> entries;
  final bool isLoading;
  final String selectedTab; // 'global' or 'friends'

  const LeaderboardState({
    required this.entries,
    required this.isLoading,
    required this.selectedTab,
  });

  LeaderboardState copyWith({
    List<LeaderboardEntry>? entries,
    bool? isLoading,
    String? selectedTab,
  }) {
    return LeaderboardState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class LeaderboardNotifier extends StateNotifier<LeaderboardState> {
  final LeaderboardRepository _repository;

  LeaderboardNotifier(this._repository)
      : super(const LeaderboardState(entries: [], isLoading: false, selectedTab: 'friends'));

  Future<void> fetchRankings(String type) async {
    state = state.copyWith(isLoading: true, selectedTab: type);
    List<LeaderboardEntry> rankings;
    if (type == 'global') {
      rankings = await _repository.getGlobalRankings();
    } else {
      rankings = await _repository.getFriendsRankings();
    }
    state = LeaderboardState(entries: rankings, isLoading: false, selectedTab: type);
  }
}

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepositoryImpl();
});

final leaderboardProvider = StateNotifierProvider<LeaderboardNotifier, LeaderboardState>((ref) {
  final repo = ref.watch(leaderboardRepositoryProvider);
  final notifier = LeaderboardNotifier(repo);
  notifier.fetchRankings('friends');
  return notifier;
});
