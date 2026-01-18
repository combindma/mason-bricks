part of 'go_router.dart';

FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state, AsyncValue<bool> onboardingState, AuthState authState) {
  final isGoingToLoading = state.matchedLocation == Routes.loading.path;
  final isGoingToOnboarding = state.matchedLocation == Routes.onboarding.path;
  final isGoingToLogin = state.matchedLocation == Routes.login.path;

  final isAuthenticating = switch (authState) {
    AuthStateAuthenticating() => true,
    _ => false,
  };

  final isLoggedIn = switch (authState) {
    AuthStateAuthenticated() => true,
    _ => false,
  };

  if (onboardingState.isLoading || authState == AuthStateInitial()) return Routes.loading.path;

  final hasSeenOnboarding = onboardingState.value ?? false;

  if (!hasSeenOnboarding) {
    return isGoingToOnboarding ? null : Routes.onboarding.path;
  }

  if (isGoingToOnboarding && hasSeenOnboarding) {
    return Routes.login.path;
  }

  if (isGoingToLoading) {
    return Routes.home.path;
  }

  if (isAuthenticating) return null;

  if (isLoggedIn && isGoingToLogin) {
    return Routes.home.path;
  }

  return null;
}
