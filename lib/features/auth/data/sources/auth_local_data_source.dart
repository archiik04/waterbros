import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/models/user.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage _storage;

  const AuthLocalDataSource(this._storage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userDataKey = 'user_data';

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: _userDataKey, value: userJson);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<User?> getUser() async {
    final userJson = await _storage.read(key: _userDataKey);
    if (userJson == null) return null;
    try {
      final Map<String, dynamic> decoded = jsonDecode(userJson) as Map<String, dynamic>;
      return User.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Future<void> clear() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userDataKey);
  }
}
