import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_interceptor.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';

class DioClient {
  static const String _defaultBaseUrl = 'http://localhost:8000/api';

  static String get baseUrl {
    // Redirect Android Emulators to host loopback address
    if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
      return 'http://10.0.2.2:8000/api';
    }
    return _defaultBaseUrl;
  }

  static Dio createDio(AuthLocalDataSource localDataSource) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Isolated Dio instance for refreshing tokens (avoids interceptor loops)
    final refreshDio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
      refreshDio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }

    dio.interceptors.add(AuthInterceptor(localDataSource, refreshDio));

    return dio;
  }
}
