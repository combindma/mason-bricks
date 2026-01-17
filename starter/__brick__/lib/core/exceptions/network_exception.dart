import 'dart:async';
import 'dart:io';

import 'base_exception.dart';

class NetworkException extends BaseException {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    if (error is SocketException) {
      return 'No internet connection';
    } else if (error is TimeoutException) {
      return 'Request timed out';
    } else {
      return 'An error occurred';
    }
  }
}
