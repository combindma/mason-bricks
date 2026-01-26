import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../lib/routes/go_router.dart';
import '../../lib/routes/routes.dart';
import '../../lib/src/auth/presentation/controllers/auth_state.dart';

@GenerateMocks([GoRouterState, BuildContext])
import 'redirect_test.mocks.dart';

void main() {
  late MockGoRouterState mockState;
  late MockBuildContext mockContext;

  setUp(() {
    mockState = MockGoRouterState();
    mockContext = MockBuildContext();
  });

  group('Onboarding redirect tests', () {
    test('Should force Onboarding if user has NOT seen it', () {
      when(mockState.matchedLocation).thenReturn(Routes.home.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        false, // hasSeenOnboarding
        const AuthStateUnauthenticated(),
      );

      expect(result, Routes.onboarding.path);
    });

    test('Should allow stay on Onboarding if user has NOT seen it', () {
      when(mockState.matchedLocation).thenReturn(Routes.onboarding.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        false,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });

    test('Should redirect to Welcome after completing Onboarding', () {
      when(mockState.matchedLocation).thenReturn(Routes.onboarding.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, Routes.welcome.path);
    });

    test('Should redirect authenticated user from Onboarding to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.onboarding.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, Routes.home.path);
    });
  });

  group('Guest access tests', () {
    test('Should allow Guest access to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.home.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });

    test('Should allow Guest access to Account', () {
      when(mockState.matchedLocation).thenReturn(Routes.account.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });

    test('Should allow Guest access to Welcome', () {
      when(mockState.matchedLocation).thenReturn(Routes.welcome.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });

    test('Should allow Guest access to Login', () {
      when(mockState.matchedLocation).thenReturn(Routes.login.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });

    test('Should allow Guest access to SignUp', () {
      when(mockState.matchedLocation).thenReturn(Routes.signup.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateUnauthenticated(),
      );

      expect(result, isNull);
    });
  });

  group('Authenticated user tests', () {
    test('Should redirect Authenticated user from Welcome to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.welcome.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, Routes.home.path);
    });

    test('Should redirect Authenticated user from Login to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.login.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, Routes.home.path);
    });

    test('Should redirect Authenticated user from SignUp to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.signup.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, Routes.home.path);
    });

    test('Should allow Authenticated user access to Home', () {
      when(mockState.matchedLocation).thenReturn(Routes.home.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, isNull);
    });

    test('Should allow Authenticated user access to Account', () {
      when(mockState.matchedLocation).thenReturn(Routes.account.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticated(),
      );

      expect(result, isNull);
    });
  });

  group('Authenticating state tests', () {
    test('Should NOT redirect while Authenticating on Login', () {
      when(mockState.matchedLocation).thenReturn(Routes.login.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticating(),
      );

      expect(result, isNull);
    });

    test('Should NOT redirect while Authenticating on SignUp', () {
      when(mockState.matchedLocation).thenReturn(Routes.signup.path);

      final result = handleRedirect(
        mockContext,
        mockState,
        true,
        const AuthStateAuthenticating(),
      );

      expect(result, isNull);
    });
  });
}