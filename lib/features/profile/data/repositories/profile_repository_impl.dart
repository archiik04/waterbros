import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  UserProfile _profile = UserProfile(
    name: 'Alex Rivera',
    username: 'alex_rivera',
    bio: 'Hydrating one day at a time! 💧',
    pronouns: 'He/Him',
    level: 7,
    currentXp: 650,
    maxXp: 1000,
    longestStreak: 12,
    weeklyWaterLiters: 12.5,
    achievements: ['First Drop', 'Streak Starter', 'Volume Champ', 'Hydration Crew'],
  );

  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  @override
  Future<void> updateProfile({String? name, String? bio, String? pronouns}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profile = UserProfile(
      name: name ?? _profile.name,
      username: _profile.username,
      bio: bio ?? _profile.bio,
      pronouns: pronouns ?? _profile.pronouns,
      level: _profile.level,
      currentXp: _profile.currentXp,
      maxXp: _profile.maxXp,
      longestStreak: _profile.longestStreak,
      weeklyWaterLiters: _profile.weeklyWaterLiters,
      achievements: _profile.achievements,
    );
  }
}
