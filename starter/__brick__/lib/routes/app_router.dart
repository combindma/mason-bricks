import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../src/auth/presentation/screens/login_screen.dart';
import '../src/auth/presentation/screens/signup_screen.dart';
import '../src/home/presentation/screens/home_screen.dart';
import '../src/home/presentation/screens/main_screen.dart';
import '../src/onboarding/presentation/screens/onboarding_screen.dart';
import '../src/user/presentation/screens/account_screen.dart';
import 'routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, GoRouterState state, StatefulNavigationShell navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.home, path: '/home', builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.account, path: '/account', builder: (context, state) => const AccountScreen())],
          ),
        ],
      ),
      GoRoute(name: Routes.onboarding, path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(name: Routes.login, path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(name: Routes.signup, path: '/sign-up', builder: (context, state) => const SignUpScreen()),
    ],
  );
});