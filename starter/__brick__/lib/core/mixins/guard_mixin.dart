import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/error_provider.dart';
import '../exceptions/app_exception.dart';

mixin GuardMixin<T> on AsyncNotifier<T> {
  Future<void> guardAndNotify(
      Future<T> Function() future, {
        String? fallbackMessage,
      }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(future);

    if (state.hasError) {
      final error = state.error;
      String message;
      if (error is AppException) {
        // 1. It's OUR custom error. We trust the message.
        message = error.message;
      } else if (error.toString().contains("SocketException")) {
        // 2. It's a network issue
        message = "Check your internet connection.";
      } else {
        // 3. It's a crash/bug we didn't expect
        message = fallbackMessage ?? "Une erreur s'est produite, veuillez réssayer ultérieurment.";
      }
      ref.read(globalErrorProvider.notifier).show(message, error);
    }
  }
}