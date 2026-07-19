import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';


/*
* Example of how you can call 'guardAndNotify' directly
* remove the state = assignment when calling it.
*
*
* await guard(
      () => await dio.get('my_api/data')
    );
*
* return guard(() async {
      await userService.updateProfile(name: name, phone: phone, address: address, city: city, postcode: postcode, country: country);
      return userService.currentUser();
});
*
*
* */
mixin GuardMixin<T> on AsyncNotifier<T> {
  /// Runs [request] as a mutation: shows loading, reports errors to
  /// [globalErrorProvider], re-syncs with the server on failure.
  /// Returns true on success. Safe against disposal mid-request.
  Future<bool> guard(Future<T> Function() request) async {
    state = const AsyncLoading();
    try {
      final data = await request();
      if (!ref.mounted) return false;
      state = AsyncData(data);
      return true;
    } catch (e, stackTrace) {
      if (!ref.mounted) return false;
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      ref.invalidateSelf();
      return false;
    }
  }
}