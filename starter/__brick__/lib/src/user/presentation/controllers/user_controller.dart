import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bootstrap/error_provider.dart';
import '../../models/user_model.dart';
import '../../user_provider.dart';
import '../../../../core/mixins/guard_mixin.dart';

final userControllerProvider = AsyncNotifierProvider<UserController, UserModel?>(isAutoDispose: false, UserController.new);

class UserController extends AsyncNotifier<UserModel?> with GuardMixin<UserModel?> {
  @override
  Future<UserModel?> build() async {
    try {
      final userService = ref.read(userServiceProvider);
      final user = await userService.currentUser();

      return user;
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      return null;
    }
  }

  Future<void> updateProfile({required String name, String? phone, String? address, String? city, String? zipCode, String? country}) async {
    final userService = ref.read(userServiceProvider);
    await guardAndNotify(() async {
      await userService.updateProfile(name: name, phone: phone, address: address, city: city, zipCode: zipCode, country: country);
      return userService.currentUser();
    });
  }
}
