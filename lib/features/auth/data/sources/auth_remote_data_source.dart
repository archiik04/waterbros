import 'package:dio/dio.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSource(this._dio);

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '/auth/login',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      '/auth/register',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post(
      '/auth/logout',
      data: {'refreshToken': refreshToken},
    );
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post(
      '/auth/forgot-password',
      data: {'email': email},
    );
  }
}
