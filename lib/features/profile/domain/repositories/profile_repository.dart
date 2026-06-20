abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<void> updateProfile({String? name, String? bio, String? pronouns});
}

class UserProfile {
  final String name;
  final String username;
  final String bio;
  final String pronouns;
  final int level;
  final int currentXp;
  final int maxXp;
  final int longestStreak;
  final double weeklyWaterLiters;
  final List<String> achievements;

  UserProfile({
    required this.name,
    required this.username,
    required this.bio,
    required this.pronouns,
    required this.level,
    required this.currentXp,
    required this.maxXp,
    required this.longestStreak,
    required this.weeklyWaterLiters,
    required this.achievements,
  });
}
