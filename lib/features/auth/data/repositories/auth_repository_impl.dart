import 'package:dio/dio.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../sources/auth_local_data_source.dart';
import '../sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<User> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _remoteDataSource.login(request);
      
      // Persist credentials locally
      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      await _localDataSource.saveUser(response.user);

      return response.user;
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('An unexpected error occurred during login');
    }
  }

  @override
  Future<User> register(String name, String email, String password) async {
    try {
      final request = RegisterRequest(name: name, email: email, password: password);
      final response = await _remoteDataSource.register(request);

      // Persist credentials locally
      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      await _localDataSource.saveUser(response.user);

      return response.user;
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('An unexpected error occurred during registration');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _localDataSource.getRefreshToken();
      if (refreshToken != null) {
        // Revoke token on server side
        await _remoteDataSource.logout(refreshToken);
      }
    } catch (_) {
      // Fail silently for server-side logout to ensure local storage gets cleared regardless
    } finally {
      // Always purge local tokens
      await _localDataSource.clear();
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('An unexpected error occurred during password reset request');
    }
  }

  @override
  Future<bool> checkAuthStatus() async {
    try {
      final refreshToken = await _localDataSource.getRefreshToken();
      final user = await _localDataSource.getUser();
      // If we have a refresh token and user record, session can be restored/refreshed
      return refreshToken != null && user != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User?> getCachedUser() async {
    return await _localDataSource.getUser();
  }

  String _extractErrorMessage(DioException err) {
    try {
      final responseData = err.response?.data;
      if (responseData is Map<String, dynamic>) {
        // Check if it's a Zod validation error list
        if (responseData.containsKey('errors') && responseData['errors'] is List) {
          final errorsList = responseData['errors'] as List;
          if (errorsList.isNotEmpty) {
            final firstError = errorsList.first;
            if (firstError is Map && firstError.containsKey('message')) {
              return firstError['message'] as String;
            }
          }
        }
        if (responseData.containsKey('message')) {
          return responseData['message'] as String;
        }
      }
    } catch (_) {}
    
    if (err.type == DioExceptionType.connectionTimeout || 
        err.type == DioExceptionType.receiveTimeout) {
      return 'Server connection timed out. Please try again.';
    }
    if (err.type == DioExceptionType.connectionError) {
      return 'Unable to connect to the server. Please check your internet connection.';
    }

    return err.message ?? 'An unexpected network error occurred';
  }
}
