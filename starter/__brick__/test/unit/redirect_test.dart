import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  group('handleRedirect Logic Tests', () {

    test('Should go to Loading if onboarding data is loading', () {
      when(mockState.matchedLocation).thenReturn(Routes.home.path);
      const onboarding = AsyncValue<bool>.loading();
      final auth = AuthStateInitial();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, Routes.loading.path);
    });

    test('Should force Onboarding if user has NOT seen it', () {
      // User tries to go Home, but hasn't seen onboarding
      when(mockState.matchedLocation).thenReturn(Routes.home.path);
      const onboarding = AsyncValue.data(false);
      final auth = AuthStateUnauthenticated();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, Routes.onboarding.path);
    });

    test('Should allow stay on Onboarding if user has NOT seen it', () {
      // User is on Onboarding, hasn't seen it. Should return null (no redirect).
      when(mockState.matchedLocation).thenReturn(Routes.onboarding.path);
      const onboarding = AsyncValue.data(false);
      final auth = AuthStateUnauthenticated();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, null);
    });

    test('Should redirect to LOGIN if user completes Onboarding', () {
      // User is on Onboarding page, but state updates to "Seen = true" (User clicked Get Started)
      when(mockState.matchedLocation).thenReturn(Routes.onboarding.path);
      const onboarding = AsyncValue.data(true);
      final auth = AuthStateUnauthenticated();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, Routes.login.path);
    });

    test('Should allow Guest access to Home (Not Logged In, Onboarding Seen)', () {
      // User is going Home, has seen onboarding, is NOT logged in.
      when(mockState.matchedLocation).thenReturn(Routes.home.path);
      const onboarding = AsyncValue.data(true);
      final auth = AuthStateUnauthenticated();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, null, reason: "Guest users should be allowed on Home");
    });

    test('Should redirect Logged In user away from Login page', () {
      // User is Authenticated, tries to go to Login.
      when(mockState.matchedLocation).thenReturn(Routes.login.path);
      const onboarding = AsyncValue.data(true);
      final auth = AuthStateAuthenticated();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, Routes.home.path);
    });

    test('Should NOT redirect while Authenticating', () {
      // Auth state is loading/authenticating.
      when(mockState.matchedLocation).thenReturn(Routes.login.path);
      const onboarding = AsyncValue.data(true);
      final auth = AuthStateAuthenticating();
      final result = handleRedirect(mockContext, mockState, onboarding, auth);
      expect(result, null);
    });
  });
}