import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/error_provider.dart';


/*
* Example of how you can call 'guardAndNotify' directly:
*
*
  Future<void> fetchData() async {
    await guardAndNotify(
      () async {
        final response = await dio.get('my_api/data');
        return MyData.fromJson(response.data);
      },
      customErrorMessage: "Unable to load data", //Optional
    );
  }
  *
  *
* */
mixin GuardMixin<T> on AsyncNotifier<T> {
  Future<void> guardAndNotify(
      Future<T> Function() future, {
        String? fallbackMessage,
      }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(future);

    if (state.hasError) {
      final error = state.error!;
      final errorHandler = ref.read(errorHandlerProvider);
      final String message = fallbackMessage ?? errorHandler.map(error, state.stackTrace);
      ref.read(globalErrorProvider.notifier).show(message, error);
    }
  }
}