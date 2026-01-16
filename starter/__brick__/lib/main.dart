import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'bootstrap/providers.dart';
import 'core/services/remote_config_service.dart';
import 'core/services/theme_service.dart';
import 'routes/app_router.dart';
import 'shared/theme/theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await RemoteConfigService().init();
  FlutterNativeSplash.remove();
  runApp(
    ProviderScope(
      //Used to observe provider lifecycle events in the application.
      //observers: [AppObserver()],
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

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode.flutterThemeMode,
        theme: BaseTheme.light,
        darkTheme: BaseTheme.dark,
        supportedLocales: const [
          Locale('fr'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        routerConfig: router,
     /* home: AppErrorListener(
        child: Container(),
      )*/
    );
  }
}