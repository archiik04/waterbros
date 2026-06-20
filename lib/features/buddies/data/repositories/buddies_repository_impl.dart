import '../../domain/repositories/buddies_repository.dart';

class BuddiesRepositoryImpl implements BuddiesRepository {
  final List<Buddy> _buddies = [
    Buddy(id: '1', name: 'Alex Johnson', username: 'alexj', currentMl: 1500, goalMl: 2500, streakDays: 5, status: 'Logged today ✓'),
    Buddy(id: '2', name: 'Sarah Miller', username: 'sarah_m', currentMl: 800, goalMl: 2000, streakDays: 12, status: 'Not logged yet'),
    Buddy(id: '3', name: 'Chris Evans', username: 'cevans', currentMl: 2000, goalMl: 2500, streakDays: 7, status: 'Logged today ✓'),
  ];

  final List<BuddyRequest> _requests = [
    BuddyRequest(id: 'r1', name: 'David Smith', username: 'davids'),
    BuddyRequest(id: 'r2', name: 'Emma Watson', username: 'emma_w'),
  ];

  @override
  Future<List<Buddy>> getBuddies() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _buddies;
  }

  @override
  Future<List<BuddyRequest>> getPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _requests;
  }

  @override
  Future<void> sendBuddyRequest(String username) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> acceptBuddyRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final req = _requests.firstWhere((element) => element.id == requestId);
    _buddies.add(Buddy(
      id: req.id,
      name: req.name,
      username: req.username,
      currentMl: 0,
      goalMl: 2000,
      streakDays: 0,
      status: 'Not logged yet',
    ));
    _requests.removeWhere((element) => element.id == requestId);
  }

  @override
  Future<void> declineBuddyRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _requests.removeWhere((element) => element.id == requestId);
  }
}
