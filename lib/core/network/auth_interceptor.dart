import 'dart:async';
import 'package:dio/dio.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _localDataSource;
  final Dio _refreshDio;
  bool _isRefreshing = false;
  final List<Completer<void>> _queue = [];

  AuthInterceptor(this._localDataSource, this._refreshDio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _localDataSource.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final responseData = err.response?.data;
      final isExpired = responseData is Map && responseData['code'] == 'ACCESS_TOKEN_EXPIRED';

      if (isExpired) {
        final requestOptions = err.requestOptions;

        if (_isRefreshing) {
          final completer = Completer<void>();
          _queue.add(completer);
          await completer.future;

          try {
            final response = await _retry(requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(DioException(requestOptions: requestOptions, error: e));
          }
        }

        _isRefreshing = true;

        try {
          final refreshToken = await _localDataSource.getRefreshToken();
          if (refreshToken == null) {
            throw Exception('No refresh token available');
          }

          final response = await _refreshDio.post(
            '/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final data = response.data as Map<String, dynamic>;
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;

          await _localDataSource.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          _isRefreshing = false;

          for (final completer in _queue) {
            completer.complete();
          }
          _queue.clear();

          final retryResponse = await _retry(requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          _isRefreshing = false;

          for (final completer in _queue) {
            completer.completeError(e);
          }
          _queue.clear();

          await _localDataSource.clear();

          return handler.next(err);
        }
      }
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await _localDataSource.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final dio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
