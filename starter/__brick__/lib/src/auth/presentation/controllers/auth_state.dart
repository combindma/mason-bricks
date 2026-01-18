import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticating extends AuthState {
  const AuthStateAuthenticating();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();

  @override
  List<Object?> get props => [];
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}