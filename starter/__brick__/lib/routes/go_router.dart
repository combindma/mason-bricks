import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/ui/splash_screen.dart';
import '../src/auth/presentation/controllers/auth_notifier_provider.dart';
import '../src/auth/presentation/controllers/auth_state.dart';
import '../src/auth/presentation/screens/login_screen.dart';
import '../src/auth/presentation/screens/signup_screen.dart';
import '../src/home/presentation/screens/home_screen.dart';
import '../src/home/presentation/screens/main_screen.dart';
import '../src/onboarding/onboarding_provider.dart';
import '../src/onboarding/presentation/screens/onboarding_screen.dart';
import '../src/user/presentation/screens/account_screen.dart';
import 'routes.dart';

part 'redirection.dart';

final rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(isAutoDispose: true, (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'));

final routerProvider = Provider<GoRouter>(isAutoDispose: true, (ref) {
  final rootKey = ref.watch(rootNavigatorKeyProvider);
  final onboardingState = ref.watch(onboardingProvider);
  final authNotifier = ref.read(authNotifierProvider.notifier);

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    initialLocation: Routes.home.path,
    refreshListenable: authNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      // CRITICAL: Use ref.read here to get the FRESH auth state, immediately when the redirect triggers.
      final authState = ref.read(authNotifierProvider);
      return handleRedirect(context, state, onboardingState, authState);
    },
    routes: [
      GoRoute(name: Routes.loading.name, path: Routes.loading.path, builder: (context, state) => const SplashScreenComponent()),
      GoRoute(name: Routes.onboarding.name, path: Routes.onboarding.path, builder: (context, state) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, GoRouterState state, StatefulNavigationShell navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.home.name, path: Routes.home.path, builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.account.name, path: Routes.account.path, builder: (context, state) => const AccountScreen())],
          ),
        ],
      ),
      GoRoute(name: Routes.login.name, path: Routes.login.path, builder: (context, state) => const LoginScreen()),
      GoRoute(name: Routes.signup.name, path: Routes.signup.path, builder: (context, state) => const SignUpScreen()),
    ],
  );
});
