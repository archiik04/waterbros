import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/challenges_repository_impl.dart';
import '../../domain/repositories/challenges_repository.dart';

class ChallengesState {
  final List<Challenge> active;
  final List<Challenge> available;
  final bool isLoading;

  const ChallengesState({
    required this.active,
    required this.available,
    required this.isLoading,
  });

  ChallengesState copyWith({
    List<Challenge>? active,
    List<Challenge>? available,
    bool? isLoading,
  }) {
    return ChallengesState(
      active: active ?? this.active,
      available: available ?? this.available,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChallengesNotifier extends StateNotifier<ChallengesState> {
  final ChallengesRepository _repository;

  ChallengesNotifier(this._repository) : super(const ChallengesState(active: [], available: [], isLoading: false));

  Future<void> fetchChallenges() async {
    state = state.copyWith(isLoading: true);
    final active = await _repository.getActiveChallenges();
    final available = await _repository.getAvailableChallenges();
    state = ChallengesState(active: active, available: available, isLoading: false);
  }

  Future<void> join(String id) async {
    await _repository.joinChallenge(id);
    await fetchChallenges();
  }

  Future<void> leave(String id) async {
    await _repository.leaveChallenge(id);
    await fetchChallenges();
  }
}

final challengesRepositoryProvider = Provider<ChallengesRepository>((ref) {
  return ChallengesRepositoryImpl();
});

final challengesProvider = StateNotifierProvider<ChallengesNotifier, ChallengesState>((ref) {
  final repo = ref.watch(challengesRepositoryProvider);
  final notifier = ChallengesNotifier(repo);
  notifier.fetchChallenges();
  return notifier;
});
