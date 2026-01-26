import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import '../../src/auth/presentation/controllers/auth_notifier_provider.dart';

class ApiService {
  ApiService(this._ref) {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(_authInterceptor());
  }

  final Ref _ref;
  late final Dio _dio;

  AuthNotifier get _auth => _ref.read(authNotifierProvider.notifier);

  // Base configuration
  static const String _baseUrl = 'https://api.example.com/v1';

  BaseOptions get _baseOptions => BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    contentType: Headers.jsonContentType,
  );

  // Auth interceptor for automatic token injection
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _auth.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle token refresh or logout
          await _auth.logout();
        }
        handler.next(error);
      },
    );
  }

  // GET
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  // POST
  Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  // PUT
  Future<Response<T>> put<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  // DELETE
  Future<Response<T>> delete<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  // PATCH
  Future<Response<T>> patch<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.patch<T>(path, data: data, queryParameters: queryParameters, options: options);
  }
}
