import 'dart:ui';

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shared/ui/offline_screen.dart';
import 'bootstrap/providers.dart';
import 'config/app_config.dart';
import 'core/extensions/extensions.dart';
import 'core/utils/device_helper.dart';
import 'core/logging/provider_observer.dart';
import 'routes/go_router.dart';
import 'shared/theme/theme.dart';
import 'core/utils/app_error_listener.dart';
import 'shared/ui/error_screen.dart';
import 'shared/ui/splash_screen.dart';
import 'src/auth/presentation/controllers/auth_notifier_provider.dart';
import 'src/onboarding/onboarding_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GoogleFonts.pendingFonts([GoogleFonts.tikTokSansTextTheme()]);
  GoogleFonts.config.allowRuntimeFetching = false;

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ProviderScope(
      observers: [AppObserver()],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        child: _EagerInitialization(child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themeControllerProvider).requireValue;
    final config = ref.watch(remoteConfigProvider).requireValue;
    final isOnline = ref.watch(connectivityProvider).requireValue;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.savedThemeMode,
      theme: BaseTheme.materialLight,
      darkTheme: BaseTheme.materialDark,
      localizationsDelegates: [
        ...context.localizationDelegates,
        CountryLocalizations.delegate,
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return ForceUpdateWidget(
          navigatorKey: ref.watch(rootNavigatorKeyProvider),
          forceUpdateClient: ForceUpdateClient(fetchRequiredVersion: () async => config.requiredMinVersion, iosAppStoreId: AppConfig.iosAppStoreId),
          allowCancel: false,
          showForceUpdateAlert: (context, allowCancel) async => await showAdaptiveDialog(
            context: context,
            builder: (_) => AlertDialog.adaptive(
              actionsAlignment: MainAxisAlignment.center,
              title: Text('update_dialog.title').tr(),
              content: Text('update_dialog.content').tr(namedArgs: {'appName': AppConfig.name}),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('update_dialog.confirm'.tr()).medium)],
            ),
          ),
          showStoreListing: (storeUrl) async {
            DeviceHelper.launch(storeUrl, LaunchMode.externalApplication);
          },
          onException: (e, st) {},
          child: AppErrorListener(child: isOnline ? child! : const OfflineScreen()),
        );
      },
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);
    final config = ref.watch(remoteConfigProvider);
    final themeController = ref.watch(themeControllerProvider);
    final authState = ref.watch(authNotifierProvider);
    final packageInfo = ref.watch(packageInfoProvider);
    final onboardingState = ref.watch(onboardingProvider);
    ref.watch(pushNotificationProvider);

    final isLoading = connectivity.isLoading || onboardingState.isLoading || themeController.isLoading || config.isLoading || authState.isLoading || packageInfo.isLoading;

    if (isLoading) {
      return buildMaterialApp(context: context, child: SplashScreenComponent());
    }

    if (config.hasError) {
      return buildMaterialApp(
        context: context,
        theme: themeController.requireValue.savedThemeMode,
        child: ErrorScreenComponent(
          onRetry: () {
            // Invalidate failed providers to retry
            ref.invalidate(remoteConfigProvider);
          },
        ),
      );
    }

    return child;
  }

  MaterialApp buildMaterialApp({required BuildContext context, ThemeMode? theme = ThemeMode.system, required Widget child}) {
    return MaterialApp(
      themeMode: theme,
      theme: BaseTheme.materialLight,
      darkTheme: BaseTheme.materialDark,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: child,
    );
  }
}