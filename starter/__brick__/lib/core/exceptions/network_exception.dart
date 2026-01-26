import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

import 'base_exception.dart';

class NetworkException implements BaseException {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    if (error is SocketException) {
      return _handleSocketException(error);
    } else if (error is TimeoutException) {
      return 'errors.network.timeout'.tr();
    } else if (error is HttpException) {
      return _handleHttpException(error);
    } else if (error is FormatException) {
      return 'errors.network.format'.tr();
    } else if (error is HandshakeException) {
      return 'errors.network.ssl'.tr();
    } else if (error is CertificateException) {
      return 'errors.network.certificate'.tr();
    }
    return 'errors.network.generic'.tr();
  }

  String _handleSocketException(SocketException error) {
    if (error.osError?.errorCode == 7) {
      return 'errors.network.no_internet'.tr();
    } else if (error.osError?.errorCode == 111) {
      return 'errors.network.connection_refused'.tr();
    } else if (error.osError?.errorCode == 101) {
      return 'errors.network.unreachable'.tr();
    }
    return 'errors.network.no_internet'.tr();
  }

  String _handleHttpException(HttpException error) {
    final message = error.message.toLowerCase();

    if (message.contains('404')) {
      return 'errors.network.not_found'.tr();
    } else if (message.contains('401') || message.contains('403')) {
      return 'errors.network.unauthorized'.tr();
    } else if (message.contains('500')) {
      return 'errors.network.server'.tr();
    } else if (message.contains('503')) {
      return 'errors.network.unavailable'.tr();
    }

    return 'errors.network.generic'.tr();
  }
}
