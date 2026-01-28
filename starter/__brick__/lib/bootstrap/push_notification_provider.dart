import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/push_notification_service.dart';
import '../src/auth/auth_provider.dart';
import '../src/auth/presentation/controllers/auth_notifier_provider.dart';
import '../src/auth/presentation/controllers/auth_state.dart';

final pushNotificationServiceProvider = Provider<PushNotificationService>(
  isAutoDispose: false,
      (ref) => PushNotificationService(),
);

final pushNotificationProvider = FutureProvider<void>(
  isAutoDispose: false,
      (ref) async {
    final service = ref.watch(pushNotificationServiceProvider);
    await service.initialize();

    // Save token when user is authenticated
    await _syncTokenIfAuthenticated(ref, service);

    // Handle token refresh
    service.onTokenRefresh.listen((token) {
      _saveTokenToFirestore(ref, token);
    });
  },
);

Future<void> _syncTokenIfAuthenticated(Ref ref, PushNotificationService service) async {
  final authState = ref.read(authNotifierProvider).requireValue;

  if (authState is AuthStateAuthenticated) {
    final token = await service.getToken();
    if (token != null) {
      await _saveTokenToFirestore(ref, token);
    }
  }
}

Future<void> _saveTokenToFirestore(Ref ref, String token) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  final user = authNotifier.currentUser();

  if (user != null) {
    final authService = ref.read(authServiceProvider);
    await authService.updateFcmToken(uid: user.uid, token: token);
  }
}