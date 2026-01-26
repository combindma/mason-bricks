import 'package:hooks_riverpod/hooks_riverpod.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthStateAuthenticating extends AuthState {
  const AuthStateAuthenticating();
}

final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

extension AsyncAuthStateX on AsyncValue<AuthState> {
  bool get isAuthenticating => value is AuthStateAuthenticating;
  bool get isAuthenticated => value is AuthStateAuthenticated;
  bool get isUnauthenticated => value is AuthStateUnauthenticated;
}