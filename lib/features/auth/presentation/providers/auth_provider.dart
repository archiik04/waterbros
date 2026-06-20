import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/sources/auth_local_data_source.dart';
import '../../data/sources/auth_remote_data_source.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState.initial()) {
    // Automatically trigger checking authentication status on launch
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final isLoggedIn = await _authRepository.checkAuthStatus();
      if (isLoggedIn) {
        final user = await _authRepository.getCachedUser();
        state = AuthState(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = const AuthState(
          status: AuthStatus.unauthenticated,
        );
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final user = await _authRepository.login(email, password);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: errorMsg,
      );
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final user = await _authRepository.register(name, email, password);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: errorMsg,
      );
    }
  }

  Future<void> logout() async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      await _authRepository.logout();
    } catch (_) {
    } finally {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> forgotPassword(String email) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      await _authRepository.forgotPassword(email);
      state = const AuthState(status: AuthStatus.unauthenticated);
      return true;
    } catch (e) {
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: errorMsg,
      );
      return false;
    }
  }
}

// Riverpod Dependency Providers
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(storage);
});

final dioProvider = Provider((ref) {
  final local = ref.watch(authLocalDataSourceProvider);
  return DioClient.createDio(local);
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remote, local);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
