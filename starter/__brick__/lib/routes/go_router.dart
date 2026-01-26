import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/ui/splash_screen.dart';
import '../src/auth/presentation/controllers/auth_notifier_provider.dart';
import '../src/auth/presentation/controllers/auth_state.dart';
import '../src/auth/presentation/screens/login_form_screen.dart';
import '../src/auth/presentation/screens/login_screen.dart';
import '../src/auth/presentation/screens/signup_form_screen.dart';
import '../src/auth/presentation/screens/signup_screen.dart';
import '../src/auth/presentation/screens/welcome_screen.dart';
import '../src/home/presentation/screens/home_screen.dart';
import '../src/home/presentation/screens/main_screen.dart';
import '../src/onboarding/onboarding_provider.dart';
import '../src/onboarding/presentation/screens/onboarding_screen.dart';
import '../src/user/presentation/screens/account_screen.dart';
import '../src/user/presentation/screens/delete_account_screen.dart';
import '../src/user/presentation/screens/edit_profile_screen.dart';
import 'routes.dart';

part 'redirection.dart';

final rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(isAutoDispose: false, (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'));

//The "Bridge" Pattern
//we need to stop rebuilding the router and instead just notify it to re-run the redirect logic.
class RouterNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

final routerProvider = Provider<GoRouter>(isAutoDispose: false, (ref) {
  final rootKey = ref.watch(rootNavigatorKeyProvider);
  final routerNotifier = RouterNotifier();

  ref.onDispose(routerNotifier.dispose);

  ref.listen(authNotifierProvider, (_, _) {
    routerNotifier.notify();
  });

  ref.listen(onboardingProvider, (_, _) {
    routerNotifier.notify();
  });

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    initialLocation: Routes.home.path,
    refreshListenable: routerNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      // CRITICAL: Always Get the FRESH value, immediately when the redirect triggers.
      final authState = ref.read(authNotifierProvider).requireValue;
      final onboardingState = ref.read(onboardingProvider).requireValue;

      return handleRedirect(context, state, onboardingState, authState);
    },
    routes: [
      GoRoute(name: Routes.loading.name, path: Routes.loading.path, builder: (context, state) => const SplashScreenComponent()),
      GoRoute(name: Routes.onboarding.name, path: Routes.onboarding.path, builder: (context, state) => const OnboardingScreen()),
      GoRoute(name: Routes.welcome.name, path: Routes.welcome.path, builder: (context, state) => const WelcomeScreen()),
      GoRoute(name: Routes.login.name, path: Routes.login.path, builder: (context, state) => const LoginScreen(), routes: [
        GoRoute(name: Routes.loginForm.name, path: Routes.loginForm.path, builder: (context, state) => const LoginFormScreen()),
      ]),
      GoRoute(name: Routes.signup.name, path: Routes.signup.path, builder: (context, state) => const SignUpScreen(), routes: [
        GoRoute(name: Routes.signupForm.name, path: Routes.signupForm.path, builder: (context, state) => const SignUpFormScreen()),
      ]),
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
      GoRoute(name: Routes.editProfile.name, path: Routes.editProfile.path, builder: (context, state) => const EditProfileScreen()),
      GoRoute(name: Routes.deleteAccount.name, path: Routes.deleteAccount.path, builder: (context, state) => const DeleteAccountScreen()),
    ],
  );
});
