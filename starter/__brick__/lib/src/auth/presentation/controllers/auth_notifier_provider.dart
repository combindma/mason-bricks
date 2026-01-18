import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    } catch (e) {
      state = const AuthStateUnauthenticated();
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
    } catch (e) {
      state = const AuthStateUnauthenticated();
    }
    _routerListener?.call();
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthStateAuthenticating();
    try {
      final auth = ref.read(authServiceProvider);
      await auth.register(email: email, password: password);
      state = const AuthStateAuthenticated();
    } catch (e) {
      state = const AuthStateUnauthenticated();
    }
    _routerListener?.call();
  }

  Future<void> logout() async {
    final auth = ref.read(authServiceProvider);
    await auth.logout();
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
