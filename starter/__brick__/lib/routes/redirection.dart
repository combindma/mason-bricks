part of 'app_router.dart';

FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state, AsyncValue<bool> onboardingState) {
  final isGoingToLoading = state.matchedLocation == Routes.loading.path;
  final isGoingToOnboarding = state.matchedLocation == Routes.onboarding.path;

  if (onboardingState.isLoading) return Routes.loading.path;
  //if (onboardingState.hasError) return '/error';
  final hasSeen = onboardingState.value ?? false;

  if (isGoingToLoading) return hasSeen ? Routes.home.path : Routes.onboarding.path;
  if (!hasSeen && !isGoingToOnboarding) return Routes.onboarding.path;
  if (hasSeen && isGoingToOnboarding) return Routes.home.path;

  return null;
}