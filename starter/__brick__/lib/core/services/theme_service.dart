import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';
import 'storage_service.dart';

enum AppThemeMode {
  light,
  dark,
  system
}

class ThemeService {
  ThemeService(this._ref);
  final Ref _ref;

  StorageService get storage => _ref.read(storageServiceProvider);

  static const String _themeModeKey = 'theme';

  Future<String?> getThemeMode() async{
    return await storage.getString(_themeModeKey);
  }

  Future<void> changeTheme(AppThemeMode themeMode) async{
    await storage.save(_themeModeKey, themeMode);
  }
}

// Extension to convert enum to string and back
extension AppThemeModeExtension on AppThemeMode {
  String get value {
    switch (this) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }

  static AppThemeMode fromString(String? value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }

  // Convert to Flutter's ThemeMode
  ThemeMode get flutterThemeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
