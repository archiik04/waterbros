import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  bool _isAuthenticated = false;
  String? _userId;

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    _userId = 'mock_user_123';
    return true;
  }

  @override
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    _userId = 'mock_user_123';
    return true;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _isAuthenticated = false;
    _userId = null;
  }

  @override
  Future<bool> checkAuthStatus() async {
    return _isAuthenticated;
  }

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  String? get currentUserId => _userId;
}
