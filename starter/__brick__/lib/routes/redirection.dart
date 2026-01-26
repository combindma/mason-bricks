part of 'go_router.dart';

final protectedRoutes = [
  Routes.editProfile.path,
  Routes.deleteAccount.path,
];

bool isProtectedRoute(String location) {
  return protectedRoutes.any((route) => location.startsWith(route));
}

FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state, bool hasSeenOnboarding, AuthState authState) {
  final location = state.matchedLocation;
  final isAuthenticated = authState is AuthStateAuthenticated;
  final isAuthenticating = authState is AuthStateAuthenticating;

  final isOnboarding = location == Routes.onboarding.path;
  final isAuthRoute = location == Routes.welcome.path ||
      location.startsWith(Routes.login.path) ||
      location.startsWith(Routes.signup.path);

  if (!hasSeenOnboarding) {
    return isOnboarding ? null : Routes.onboarding.path;
  }

  if (isAuthenticating) return null;

  if (isOnboarding) {
    return isAuthenticated ? Routes.home.path : Routes.welcome.path;
  }

  if (isAuthenticated && isAuthRoute) {
    return Routes.home.path;
  }

  if (!isAuthenticated && isProtectedRoute(location)) {
    return Routes.welcome.path;
  }

  return null;
}