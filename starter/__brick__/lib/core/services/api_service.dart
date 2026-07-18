import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import '../../src/auth/presentation/controllers/auth_notifier_provider.dart';
import '../exceptions/api_exception.dart';


class ApiService {
  ApiService(this._ref, this._baseUrl) {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(_authInterceptor());
  }

  final Ref _ref;
  final String _baseUrl;
  late final Dio _dio;

  AuthNotifier get _auth => _ref.read(authNotifierProvider.notifier);

  BaseOptions get _baseOptions => BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    contentType: Headers.jsonContentType,
    // Laravel only guarantees JSON error envelopes when the client asks for JSON.
    headers: {Headers.acceptHeader: Headers.jsonContentType},
  );

  // Auth interceptor for automatic token injection
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept-Language'] =
            PlatformDispatcher.instance.locale.toLanguageTag();
        final token = await _auth.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Only an invalidated token warrants a logout; a 401 on an
        // unauthenticated call (e.g. failed login) must not trigger one.
        final hadToken = error.requestOptions.headers.containsKey('Authorization');
        if (error.response?.statusCode == 401 && hadToken) {
          await _auth.logout();
        }
        handler.next(error);
      },
    );
  }

  /// Converts [DioException]s into typed [ApiException]s, preserving the
  /// original stack trace. Cancellations are rethrown untouched so debounced
  /// callers can recognize them.
  Future<Response<dynamic>> _guard(Future<Response<dynamic>> Function() request) async {
    try {
      return await request();
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.cancel) rethrow;
      Error.throwWithStackTrace(
        ApiException.fromDioException(exception),
        exception.stackTrace,
      );
    }
  }

  /// Extracts `data` from the Laravel envelope `{success, message, data, errors}`.
  ///
  /// A 2xx without a valid envelope, with `success: false`, or with a payload
  /// that doesn't match [T] is a backend contract break, never a user mistake.
  static T _unwrap<T>(Response<dynamic> response) {
    final body = response.data;
    if (body is Map<String, dynamic> && body['success'] == true) {
      final data = body['data'];
      if (data is T) return data;
    }
    throw UnknownApiException('errors.network.format'.tr(), statusCode: response.statusCode);
  }

  /// Each verb returns the envelope's `data` payload cast to [T]
  /// (e.g. `Map<String, dynamic>` for objects, `List<dynamic>` for
  /// collections). Omit [T] when the payload is `null` or irrelevant.

  // GET
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _unwrap<T>(await _guard(() => _dio.get<dynamic>(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken)));
  }

  // POST
  Future<T> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _unwrap<T>(await _guard(() => _dio.post<dynamic>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)));
  }

  // PUT
  Future<T> put<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _unwrap<T>(await _guard(() => _dio.put<dynamic>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)));
  }

  // DELETE
  Future<T> delete<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _unwrap<T>(await _guard(() => _dio.delete<dynamic>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)));
  }

  // PATCH
  Future<T> patch<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _unwrap<T>(await _guard(() => _dio.patch<dynamic>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)));
  }
}
