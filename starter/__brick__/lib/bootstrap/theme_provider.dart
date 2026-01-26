import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/enums/theme_mode.dart';
import 'storage_provider.dart';

final themeControllerProvider = AsyncNotifierProvider<ThemeController, AppThemeMode>(isAutoDispose: false, ThemeController.new);

class ThemeController extends AsyncNotifier<AppThemeMode> {
  @override
  Future<AppThemeMode> build() async{
    try {
      final storage = ref.read(storageServiceProvider);
      final savedThemeMode = await storage.getString('theme');
      if (savedThemeMode == null) {
        return AppThemeMode.system;
      }
      return AppThemeMode.fromString(savedThemeMode);
    } catch (_) {
      return AppThemeMode.system;
    }
  }

  Future<void> _saveTheme(String value) async {
    final storage = ref.read(storageServiceProvider);
    await storage.save('theme', value);
  }

  Future<void> toggle(String? value) async{
    final selectedValue = AppThemeMode.fromString(value ?? 'system');
    await _saveTheme(selectedValue.name);
    state = AsyncData(selectedValue);
  }

  Future<void> toggleDark() async{
    await _saveTheme(AppThemeMode.dark.name);
    state = AsyncData(AppThemeMode.dark);
  }

  Future<void> toggleLight() async{
    await _saveTheme(AppThemeMode.light.name);
    state = AsyncData(AppThemeMode.light);
  }

  Future<void> toggleSystem() async{
    await _saveTheme(AppThemeMode.system.name);
    state = AsyncData(AppThemeMode.system);
  }
}