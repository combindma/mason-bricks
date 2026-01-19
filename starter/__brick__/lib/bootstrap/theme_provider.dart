import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/enums/theme_mode.dart';
import 'storage_provider.dart';

final themeControllerProvider = AsyncNotifierProvider<ThemeController, AppThemeMode>(isAutoDispose: false, ThemeController.new);

class ThemeController extends AsyncNotifier<AppThemeMode> {
  @override
  FutureOr<AppThemeMode> build() async{
    final storage = ref.read(storageServiceProvider);
    final savedThemeMode = await storage.getString('theme');
    if (savedThemeMode == null) {
      return AppThemeMode.system;
    }
    return AppThemeMode.fromString(savedThemeMode);
  }

  Future<void> saveTheme(String value) async {
    final storage = ref.read(storageServiceProvider);
    await storage.save('theme', value);
  }

  Future<void> toggle(String? value) async{
    final selectedValue = AppThemeMode.fromString(value ?? 'system');
    state = AsyncData(selectedValue);
    await saveTheme(selectedValue.name);
  }

  Future<void> toggleDark() async{
    state = AsyncData(AppThemeMode.dark);
    await saveTheme(AppThemeMode.dark.name);
  }

  Future<void> toggleLight() async{
    state = AsyncData(AppThemeMode.light);
    await saveTheme(AppThemeMode.light.name);
  }

  Future<void> toggleSystem() async{
    state = AsyncData(AppThemeMode.system);
    await saveTheme(AppThemeMode.system.name);
  }
}