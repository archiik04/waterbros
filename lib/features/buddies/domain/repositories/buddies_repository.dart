abstract class BuddiesRepository {
  Future<List<Buddy>> getBuddies();
  Future<List<BuddyRequest>> getPendingRequests();
  Future<void> sendBuddyRequest(String username);
  Future<void> acceptBuddyRequest(String requestId);
  Future<void> declineBuddyRequest(String requestId);
}

class Buddy {
  final String id;
  final String name;
  final String username;
  final double currentMl;
  final double goalMl;
  final int streakDays;
  final String status;

  Buddy({
    required this.id,
    required this.name,
    required this.username,
    required this.currentMl,
    required this.goalMl,
    required this.streakDays,
    required this.status,
  });
}

class BuddyRequest {
  final String id;
  final String name;
  final String username;

  BuddyRequest({
    required this.id,
    required this.name,
    required this.username,
  });
}
