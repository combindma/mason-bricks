import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorEvent {
  final String message;
  final Object? originalException;

  ErrorEvent(this.message, [this.originalException]);
}

class GlobalErrorNotifier extends Notifier<ErrorEvent?> {
  @override
  ErrorEvent? build() {
    return null;
  }

  void show(String message, [Object? exception]) {
    state = ErrorEvent(message, exception);
  }
}

final globalErrorProvider = NotifierProvider<GlobalErrorNotifier, ErrorEvent?>(GlobalErrorNotifier.new);