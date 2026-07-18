import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../exceptions/index.dart';

/// HTTP client for the Strapi CMS.
///
/// Deliberately separate from `ApiService`: different backend, static token
/// auth, its own `{data, meta}` envelope, and none of the Laravel
/// interceptors — a CMS 401 must never log the user out.
class CmsApiService {
  CmsApiService({required String baseUrl, required String token}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        'Authorization': 'Bearer $token',
      },
    ));
  }

  late final Dio _dio;

  /// Returns the Strapi envelope's `data` payload cast to [T]
  /// (`Map<String, dynamic>` for single entries, `List<dynamic>` for
  /// collections).
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get<dynamic>(path, queryParameters: queryParameters, cancelToken: cancelToken);
      return _unwrap<T>(response);
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.cancel) rethrow;
      Error.throwWithStackTrace(
        ApiException.fromDioException(exception),
        exception.stackTrace,
      );
    }
  }

  static T _unwrap<T>(Response<dynamic> response) {
    final body = response.data;
    if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is T) return data;
    }
    throw UnknownApiException('errors.network.format'.tr(), statusCode: response.statusCode);
  }
}
