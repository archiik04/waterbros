import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final List<LeaderboardEntry> _global = [
    LeaderboardEntry(rank: 1, name: 'John Doe', username: 'johndoe', score: 3200, scoreUnit: 'XP'),
    LeaderboardEntry(rank: 2, name: 'Jane Smith', username: 'janesmith', score: 2950, scoreUnit: 'XP'),
    LeaderboardEntry(rank: 3, name: 'Robert Lee', username: 'robertl', score: 2800, scoreUnit: 'XP'),
    LeaderboardEntry(rank: 12, name: 'You', username: 'user123', score: 1850, scoreUnit: 'XP', isCurrentUser: true),
  ];

  final List<LeaderboardEntry> _friends = [
    LeaderboardEntry(rank: 1, name: 'Chris Evans', username: 'cevans', score: 2000, scoreUnit: 'ml'),
    LeaderboardEntry(rank: 2, name: 'You', username: 'user123', score: 1850, scoreUnit: 'ml', isCurrentUser: true),
    LeaderboardEntry(rank: 3, name: 'Alex Johnson', username: 'alexj', score: 1500, scoreUnit: 'ml'),
    LeaderboardEntry(rank: 4, name: 'Sarah Miller', username: 'sarah_m', score: 800, scoreUnit: 'ml'),
  ];

  @override
  Future<List<LeaderboardEntry>> getGlobalRankings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _global;
  }

  @override
  Future<List<LeaderboardEntry>> getFriendsRankings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _friends;
  }
}
