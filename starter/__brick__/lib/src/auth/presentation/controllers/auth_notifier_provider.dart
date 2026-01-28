import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bootstrap/providers.dart';
import '../../auth_provider.dart';
import 'auth_state.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(isAutoDispose: false, AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async{
    try {
      final auth = ref.read(authServiceProvider);
      final isAuthenticated = await auth.checkIfAuthenticated();

      return isAuthenticated
          ? const AuthStateAuthenticated()
          : const AuthStateUnauthenticated();
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      return const AuthStateUnauthenticated();
    }
  }

  User? currentUser() {
    try {
      final auth = ref.read(authServiceProvider);
      final user = auth.getCurrentUserData();
      if (user != null) {
        return user;
      }
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    return null;
  }

  Future<String?> getToken() async{
    try {
      final auth = ref.read(authServiceProvider);
      final user = auth.getCurrentUserData();
      if (user != null) {
        return await user.getIdToken();
      }
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await _saveFcmToken();
      state = const AsyncData(AuthStateAuthenticated());
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithGoogle();
      await _saveFcmToken();
      state = const AsyncData(AuthStateAuthenticated());
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
    }
  }

  Future<void> loginWithApple() async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithApple();
      await _saveFcmToken();
      state = const AsyncData(AuthStateAuthenticated());
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
    }
  }

  Future<void> signup({required String name, required String email, required String password}) async {
    state = const AsyncData(AuthStateAuthenticating());

    try {
      final auth = ref.read(authServiceProvider);
      await auth.register(name: name, email: email, password: password);
      await _saveFcmToken();
      state = const AsyncData(AuthStateAuthenticated());
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
    }
  }

  Future<bool> logout() async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      // Clear FCM token before logout
      await _clearFcmToken();
      final auth = ref.read(authServiceProvider);
      await auth.logout();
      state = const AsyncData(AuthStateUnauthenticated());
      return true;
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
      return false;
    }
  }

  Future<bool> removeAccount({String? password}) async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      // Clear FCM token before logout
      await _clearFcmToken();
      final auth = ref.read(authServiceProvider);
      await auth.deleteAccount(password: password);
      state = const AsyncData(AuthStateUnauthenticated());
      return true;
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
      return false;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    state = const AsyncData(AuthStateAuthenticating());
    try {
      final auth = ref.read(authServiceProvider);
      await auth.sendPasswordResetEmail(email: email);
      state = const AsyncData(AuthStateUnauthenticated());
      return true;
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      state = const AsyncData(AuthStateUnauthenticated());
      return false;
    }
  }

  Future<void> _saveFcmToken() async {
    final auth = ref.read(authServiceProvider);
    final user = auth.getCurrentUserData();
    if (user == null) {
      return;
    }

    final pushService = ref.read(pushNotificationServiceProvider);
    final token = await pushService.getToken();

    if (token != null) {
      await auth.updateFcmToken(uid: user.uid, token: token);
    }
  }

  Future<void> _clearFcmToken() async {
    final auth = ref.read(authServiceProvider);
    final user = auth.getCurrentUserData();
    if (user == null) {
      return;
    }

    await auth.clearFcmToken(uid: user.uid);
  }
}