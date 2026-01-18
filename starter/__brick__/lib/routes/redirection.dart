part of 'app_router.dart';

FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state, AsyncValue<bool> onboardingState) {
  final isGoingToLoading = state.matchedLocation == '/${Routes.loading}';
  final isGoingToOnboarding = state.matchedLocation == '/${Routes.onboarding}';

  if (onboardingState.isLoading) return '/${Routes.loading}';
  //if (onboardingState.hasError) return '/error';
  final hasSeen = onboardingState.value ?? false;

  if (isGoingToLoading) return hasSeen ? '/${Routes.home}' : '/${Routes.onboarding}';
  if (!hasSeen && !isGoingToOnboarding) return '/${Routes.onboarding}';
  if (hasSeen && isGoingToOnboarding) return '/${Routes.home}';

  return null;
}