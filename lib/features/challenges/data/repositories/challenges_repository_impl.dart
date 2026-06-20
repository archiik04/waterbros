import '../../domain/repositories/challenges_repository.dart';

class ChallengesRepositoryImpl implements ChallengesRepository {
  final List<Challenge> _challenges = [
    Challenge(
      id: 'c1',
      title: 'Hydration Hero',
      description: 'Log 3L+ this week to win rewards.',
      timeRemaining: '4 days, 12 hours left',
      progress: 1.8,
      goal: 3.0,
      participantsCount: 247,
      isJoined: true,
      type: 'VOLUME',
    ),
    Challenge(
      id: 'c2',
      title: 'Consistency King',
      description: 'Drink at least 2L per day for 7 days straight.',
      timeRemaining: '2 days left',
      progress: 5.0,
      goal: 7.0,
      participantsCount: 89,
      isJoined: false,
      type: 'STREAK',
    ),
    Challenge(
      id: 'c3',
      title: 'Weekend Splash',
      description: 'Log 4L over the weekend.',
      timeRemaining: 'Starts in 3 days',
      progress: 0.0,
      goal: 4.0,
      participantsCount: 156,
      isJoined: false,
      type: 'VOLUME',
    ),
  ];

  @override
  Future<List<Challenge>> getActiveChallenges() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _challenges.where((element) => element.isJoined).toList();
  }

  @override
  Future<List<Challenge>> getAvailableChallenges() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _challenges.where((element) => !element.isJoined).toList();
  }

  @override
  Future<void> joinChallenge(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final idx = _challenges.indexWhere((element) => element.id == challengeId);
    if (idx != -1) {
      final old = _challenges[idx];
      _challenges[idx] = Challenge(
        id: old.id,
        title: old.title,
        description: old.description,
        timeRemaining: old.timeRemaining,
        progress: old.progress,
        goal: old.goal,
        participantsCount: old.participantsCount + 1,
        isJoined: true,
        type: old.type,
      );
    }
  }

  @override
  Future<void> leaveChallenge(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final idx = _challenges.indexWhere((element) => element.id == challengeId);
    if (idx != -1) {
      final old = _challenges[idx];
      _challenges[idx] = Challenge(
        id: old.id,
        title: old.title,
        description: old.description,
        timeRemaining: old.timeRemaining,
        progress: old.progress,
        goal: old.goal,
        participantsCount: old.participantsCount - 1,
        isJoined: false,
        type: old.type,
      );
    }
  }
}
