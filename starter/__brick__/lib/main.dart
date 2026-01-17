import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'firebase_options.dart';
import 'bootstrap/providers.dart';
import 'config/app_config.dart';
import 'core/utils/device_helper.dart';
import 'core/logging/provider_observer.dart';
import 'core/services/remote_config_service.dart';
import 'core/services/theme_service.dart';
import 'routes/app_router.dart';
import 'shared/theme/theme.dart';
import 'core/helpers/app_error_listener.dart';
import 'core/helpers/show_alert_dialog.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await RemoteConfigService.init();
  FlutterNativeSplash.remove();
  runApp(
    ProviderScope(
      observers: [AppObserver()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeSwitcherProvider);
    final rootKey = ref.watch(rootNavigatorKeyProvider);

    return _EagerInitialization(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode.flutterThemeMode,
        theme: BaseTheme.light,
        darkTheme: BaseTheme.dark,
        supportedLocales: const [Locale('fr')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        routerConfig: router,
        builder: (context, child) {
          return ForceUpdateWidget(
            navigatorKey: rootKey,
            forceUpdateClient: ForceUpdateClient(
              fetchRequiredVersion: () async => RemoteConfigService.requiredMinVersion,
              iosAppStoreId: AppConfig.iosAppStoreId,
            ),
            allowCancel: false,
            showForceUpdateAlert: (context, allowCancel) => showAlertDialog(
              context: context,
              title: 'Mise à jour de l\'application requise',
              content:
              'La version d\'appli que tu as n\'est plus valide. Nous t\'invitons à mettre à jour ton appli ${AppConfig.name}.',
              cancelActionText: allowCancel ? 'Ignorer' : null,
              defaultActionText: 'Mettre à jour',
            ),
            showStoreListing: (storeUrl) async {
              DeviceHelper.launch(storeUrl, LaunchMode.externalApplication);
            },
            onException: (e, st) {},
            child: AppErrorListener(child: child!),
          );
        },
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Example: ref.watch(authListenerProvider);
    // Example: ref.watch(analyticsProvider);
    return child;
  }
}
