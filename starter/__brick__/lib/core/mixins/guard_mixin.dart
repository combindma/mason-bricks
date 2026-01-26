import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';


/*
* Example of how you can call 'guardAndNotify' directly
* remove the state = assignment when calling it.
*
*
  Future<void> fetchData() async {
    await guardAndNotify(
      () async {
        final response = await dio.get('my_api/data');
        return MyData.fromJson(response.data);
      }
    );
  }
  *
  *
* */
mixin GuardMixin<T> on AsyncNotifier<T> {
  Future<void> guardAndNotify(Future<T> Function() future) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(future);

    if (state.hasError) {
      final error = state.error!;
      ref.read(globalErrorProvider.notifier).handle(error, state.stackTrace);
    }
  }
}