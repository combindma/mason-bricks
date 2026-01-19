import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/exceptions/index.dart';

final globalErrorProvider = NotifierProvider<GlobalErrorNotifier, ErrorEvent?>(GlobalErrorNotifier.new);

class GlobalErrorNotifier extends Notifier<ErrorEvent?> {
  @override
  ErrorEvent? build() {
    return null;
  }

  void handle(Object error, [StackTrace? stackTrace]) {
    // You can log the error to Crashlytics/Sentry here using another provider
    // ref.read(loggerProvider).log(error, stackTrace);
    final message = _map(error);
    state = ErrorEvent(message, error);
  }

  String _map(Object error) {
    if (error is SocketException || error is TimeoutException || error.toString().contains("SocketException")) {
      return NetworkException().handleError(error);
    } else if (error is FirebaseAuthException || error is FirebaseException) {
      return FirebaseExceptionHandler().handleError(error);
    }

    return GenericException().handleError(error);
  }
}

class ErrorEvent {
  final String message;
  final Object? originalException;

  ErrorEvent(this.message, [this.originalException]);
}