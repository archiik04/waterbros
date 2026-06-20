abstract class ChallengesRepository {
  Future<List<Challenge>> getActiveChallenges();
  Future<List<Challenge>> getAvailableChallenges();
  Future<void> joinChallenge(String challengeId);
  Future<void> leaveChallenge(String challengeId);
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final String timeRemaining;
  final double progress;
  final double goal;
  final int participantsCount;
  final bool isJoined;
  final String type; // e.g. "VOLUME", "STREAK"

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.timeRemaining,
    required this.progress,
    required this.goal,
    required this.participantsCount,
    required this.isJoined,
    required this.type,
  });
}
