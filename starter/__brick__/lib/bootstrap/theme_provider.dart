import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core/services/theme_service.dart';

final themeServiceProvider = Provider<ThemeService>(isAutoDispose: false, (ref) => ThemeService(ref));

final themeSwitcherProvider = NotifierProvider<ThemeSwitcher, AppThemeMode>(isAutoDispose: false, ThemeSwitcher.new);

class ThemeSwitcher extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    return AppThemeMode.system;
    //TODO
    /*final savedThemeMode = ref.read(themeServiceProvider).getThemeMode();
    if (savedThemeMode == null) {
      return AppThemeMode.system;
    }
    return AppThemeModeExtension.fromString(savedThemeMode);*/
  }

  void toggle(String? value) {
    final selectedValue = AppThemeModeExtension.fromString(value ?? 'system');
    state = selectedValue;
    ref.read(themeServiceProvider).changeTheme(selectedValue);
  }

  void toggleDark() {
    state = AppThemeMode.dark;
    ref.read(themeServiceProvider).changeTheme(AppThemeMode.dark);
  }

  void toggleLight() {
    state = AppThemeMode.light;
    ref.read(themeServiceProvider).changeTheme(AppThemeMode.light);
  }

  void toggleSystem() {
    state = AppThemeMode.system;
    ref.read(themeServiceProvider).changeTheme(AppThemeMode.system);
  }
}