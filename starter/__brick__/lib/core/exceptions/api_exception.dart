import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

/// Typed representation of an API failure.
///
/// [message] is always safe to display: the Laravel `message` field when the
/// response carries the standard envelope
/// (`{success, message, data, errors}`), otherwise a localized fallback.
sealed class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  /// Maps a [DioException] to a typed [ApiException].
  ///
  /// Cancellation is intentionally not handled here: `ApiService` rethrows
  /// [DioExceptionType.cancel] untouched so debounced callers can detect it.
  factory ApiException.fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout =>
        ConnectionException('errors.network.timeout'.tr()),
      DioExceptionType.connectionError =>
        ConnectionException('errors.network.no_internet'.tr()),
      DioExceptionType.badCertificate =>
        ConnectionException('errors.network.certificate'.tr()),
      DioExceptionType.badResponse => _fromResponse(exception.response),
      // Some platforms report socket failures as `unknown` instead of
      // `connectionError`.
      DioExceptionType.cancel || DioExceptionType.unknown =>
        exception.error is SocketException
            ? ConnectionException('errors.network.no_internet'.tr())
            : UnknownApiException('errors.unknown'.tr()),
    };
  }

  static ApiException _fromResponse(Response<dynamic>? response) {
    final envelope = _LaravelEnvelope.parse(response?.data);
    final statusCode = response?.statusCode ?? 0;
    final message = envelope.message;

    return switch (statusCode) {
      400 => BadRequestException(message ?? 'errors.network.generic'.tr()),
      401 => UnauthorizedException(message ?? 'errors.network.unauthorized'.tr()),
      403 => ForbiddenException(message ?? 'errors.network.unauthorized'.tr()),
      404 => NotFoundException(message ?? 'errors.network.not_found'.tr()),
      422 => ValidationException(
          message ?? 'errors.network.generic'.tr(),
          fieldErrors: envelope.fieldErrors,
        ),
      >= 500 => ServerException('errors.network.server'.tr(), statusCode: statusCode),
      _ => UnknownApiException(message ?? 'errors.unknown'.tr(), statusCode: statusCode),
    };
  }

  @override
  String toString() => '$runtimeType($statusCode): $message';
}

final class BadRequestException extends ApiException {
  const BadRequestException(super.message) : super(statusCode: 400);
}

final class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message) : super(statusCode: 401);
}

final class ForbiddenException extends ApiException {
  const ForbiddenException(super.message) : super(statusCode: 403);
}

final class NotFoundException extends ApiException {
  const NotFoundException(super.message) : super(statusCode: 404);
}

/// Laravel validation failure (422); [fieldErrors] maps each field name to
/// its validation messages, ready for inline display under form inputs.
final class ValidationException extends ApiException {
  const ValidationException(super.message, {this.fieldErrors = const {}})
      : super(statusCode: 422);

  final Map<String, List<String>> fieldErrors;

  List<String>? errorsFor(String field) => fieldErrors[field];
}

final class ServerException extends ApiException {
  const ServerException(super.message, {super.statusCode});
}

/// Transport-level failure (timeout, no connectivity, bad certificate).
final class ConnectionException extends ApiException {
  const ConnectionException(super.message);
}

final class UnknownApiException extends ApiException {
  const UnknownApiException(super.message, {super.statusCode});
}

class _LaravelEnvelope {
  const _LaravelEnvelope({this.message, this.fieldErrors = const {}});

  final String? message;
  final Map<String, List<String>> fieldErrors;

  /// Tolerates non-envelope bodies (e.g. HTML error pages from a proxy).
  static _LaravelEnvelope parse(dynamic data) {
    if (data is! Map<String, dynamic>) return const _LaravelEnvelope();

    final message = data['message'];
    final errors = data['errors'];

    return _LaravelEnvelope(
      message: message is String && message.isNotEmpty ? message : null,
      fieldErrors: errors is Map<String, dynamic>
          ? errors.map(
              (field, messages) => MapEntry(
                field,
                messages is List ? messages.whereType<String>().toList() : const <String>[],
              ),
            )
          : const {},
    );
  }
}
