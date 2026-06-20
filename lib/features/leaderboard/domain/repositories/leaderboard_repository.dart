abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> getGlobalRankings();
  Future<List<LeaderboardEntry>> getFriendsRankings();
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final String username;
  final double score;
  final String scoreUnit;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.username,
    required this.score,
    required this.scoreUnit,
    this.isCurrentUser = false,
  });
}
