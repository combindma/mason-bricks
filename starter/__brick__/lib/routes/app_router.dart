import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/ui/splash_screen.dart';
import '../src/auth/presentation/screens/login_screen.dart';
import '../src/auth/presentation/screens/signup_screen.dart';
import '../src/home/presentation/screens/home_screen.dart';
import '../src/home/presentation/screens/main_screen.dart';
import '../src/onboarding/presentation/controllers/onboarding_controller.dart';
import '../src/onboarding/presentation/screens/onboarding_screen.dart';
import '../src/user/presentation/screens/account_screen.dart';
import 'routes.dart';

part 'redirection.dart';

final rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(isAutoDispose: true, (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'));

final routerProvider = Provider<GoRouter>(isAutoDispose: true, (ref) {
  final rootKey = ref.watch(rootNavigatorKeyProvider);
  final onboardingState = ref.watch(onboardingControllerProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    initialLocation: '/${Routes.home}',
    redirect: (BuildContext context, GoRouterState state) => handleRedirect(context, state, onboardingState),
    routes: [
      /***************
       * Loading/Onboarding
       ***************/
      GoRoute(
        name: Routes.loading,
        path: '/${Routes.loading}',
        builder: (context, state) => const SplashScreenComponent(),
      ),
      GoRoute(name: Routes.onboarding, path: '/${Routes.onboarding}', builder: (context, state) => const OnboardingScreen()),
      /***************
       * Home
       ***************/
      StatefulShellRoute.indexedStack(
        builder: (context, GoRouterState state, StatefulNavigationShell navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.home, path: '/${Routes.home}', builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(name: Routes.account, path: '/${Routes.account}', builder: (context, state) => const AccountScreen())],
          ),
        ],
      ),
      GoRoute(name: Routes.login, path: '/${Routes.login}', builder: (context, state) => const LoginScreen()),
      GoRoute(name: Routes.signup, path: '/${Routes.signup}', builder: (context, state) => const SignUpScreen()),
    ],
  );
});