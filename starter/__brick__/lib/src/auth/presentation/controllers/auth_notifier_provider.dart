import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bootstrap/providers.dart';
import '../../auth_provider.dart';
import 'auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(isAutoDispose: false, () => AuthNotifier()..checkIfAuthenticated());

class AuthNotifier extends Notifier<AuthState> implements Listenable {
  VoidCallback? _routerListener;

  @override
  AuthState build() {
    return const AuthStateInitial();
  }

  Future<void> checkIfAuthenticated() async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      final isAuthenticated = await auth.checkIfAuthenticated();

      if (isAuthenticated) {
        state = const AuthStateAuthenticated();
      } else {
        state = const AuthStateUnauthenticated();
      }
    } catch (e, stackTrace) {
      state = const AuthStateUnauthenticated();
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    } finally {
      _routerListener?.call();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      state = const AuthStateAuthenticated();
    } catch (e, stackTrace) {
      state = const AuthStateUnauthenticated();
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    _routerListener?.call();
  }

  Future<void> loginWithGoogle() async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithGoogle();
      state = const AuthStateAuthenticated();
    } catch (e, stackTrace) {
      state = const AuthStateUnauthenticated();
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    _routerListener?.call();
  }

  Future<void> loginWithApple() async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithApple();
      state = const AuthStateAuthenticated();
    } catch (e, stackTrace) {
      state = const AuthStateUnauthenticated();
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    _routerListener?.call();
  }

  Future<void> signup({required String name, required String email, required String password}) async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      await auth.register(name: name, email: email, password: password);
      state = const AuthStateAuthenticated();
    } catch (e, stackTrace) {
      state = const AuthStateUnauthenticated();
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    _routerListener?.call();
  }

  Future<void> logout() async {
    try {
      final auth = ref.read(authServiceProvider);
      await auth.logout();
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }

  Future<void> resetPassword({required String email}) async {
    try {
      final auth = ref.read(authServiceProvider);
      await auth.sendPasswordResetEmail(email: email);
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
    }
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
