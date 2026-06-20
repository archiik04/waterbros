import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/buddies_repository_impl.dart';
import '../../domain/repositories/buddies_repository.dart';

class BuddiesState {
  final List<Buddy> buddies;
  final List<BuddyRequest> requests;
  final bool isLoading;

  const BuddiesState({
    required this.buddies,
    required this.requests,
    required this.isLoading,
  });

  BuddiesState copyWith({
    List<Buddy>? buddies,
    List<BuddyRequest>? requests,
    bool? isLoading,
  }) {
    return BuddiesState(
      buddies: buddies ?? this.buddies,
      requests: requests ?? this.requests,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BuddiesNotifier extends StateNotifier<BuddiesState> {
  final BuddiesRepository _repository;

  BuddiesNotifier(this._repository) : super(const BuddiesState(buddies: [], requests: [], isLoading: false));

  Future<void> fetchBuddies() async {
    state = state.copyWith(isLoading: true);
    final buddies = await _repository.getBuddies();
    final requests = await _repository.getPendingRequests();
    state = BuddiesState(buddies: buddies, requests: requests, isLoading: false);
  }

  Future<void> acceptRequest(String id) async {
    await _repository.acceptBuddyRequest(id);
    await fetchBuddies();
  }

  Future<void> declineRequest(String id) async {
    await _repository.declineBuddyRequest(id);
    await fetchBuddies();
  }

  Future<void> sendRequest(String username) async {
    await _repository.sendBuddyRequest(username);
  }
}

final buddiesRepositoryProvider = Provider<BuddiesRepository>((ref) {
  return BuddiesRepositoryImpl();
});

final buddiesProvider = StateNotifierProvider<BuddiesNotifier, BuddiesState>((ref) {
  final repo = ref.watch(buddiesRepositoryProvider);
  final notifier = BuddiesNotifier(repo);
  notifier.fetchBuddies();
  return notifier;
});
