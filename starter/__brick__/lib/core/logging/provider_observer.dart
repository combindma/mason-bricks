import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logger.dart';

final class AppObserver extends ProviderObserver {
  @override
  void didAddProvider(
      ProviderObserverContext context,
      Object? value,
      ) {
    AppLogger.info('Provider ${context.provider} was initialized with $value');
  }

  @override
  void didDisposeProvider(
      ProviderObserverContext context,
      ) {
    AppLogger.info('Provider ${context.provider} was disposed');
  }

  @override
  void didUpdateProvider(
      ProviderObserverContext context,
      Object? previousValue,
      Object? newValue,
      ) {
    AppLogger.info('Provider ${context.provider} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(
      ProviderObserverContext context,
      Object error,
      StackTrace stackTrace,
      ) {
    AppLogger.debug('Provider ${context.provider} threw $error at $stackTrace');
  }
}