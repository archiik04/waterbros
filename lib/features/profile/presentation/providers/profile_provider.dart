import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileState {
  final UserProfile? profile;
  final bool isLoading;

  const ProfileState({
    this.profile,
    required this.isLoading,
  });

  ProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileState(isLoading: false));

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true);
    final profile = await _repository.getUserProfile();
    state = ProfileState(profile: profile, isLoading: false);
  }

  Future<void> updateProfile({String? name, String? bio, String? pronouns}) async {
    state = state.copyWith(isLoading: true);
    await _repository.updateProfile(name: name, bio: bio, pronouns: pronouns);
    await fetchProfile();
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  final notifier = ProfileNotifier(repo);
  notifier.fetchProfile();
  return notifier;
});
