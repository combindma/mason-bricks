import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/enums/theme_mode.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../bootstrap/theme_provider.dart';

class AppearanceDialog extends ConsumerWidget {
  const AppearanceDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.start,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('appearance'.tr(), style: context.labelLarge),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ThemeOption(
            label: 'theme.system'.tr(),
            icon: HugeIcons.strokeRoundedSmartPhone01,
            isSelected: themeMode.requireValue == AppThemeMode.system,
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleSystem();
              Navigator.of(context).pop();
            },
          ),
          _ThemeOption(
            label: 'theme.light'.tr(),
            icon: HugeIcons.strokeRoundedSun03,
            isSelected: themeMode.requireValue == AppThemeMode.light,
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleLight();
              Navigator.of(context).pop();
            },
          ),
          _ThemeOption(
            label: 'theme.dark'.tr(),
            icon: HugeIcons.strokeRoundedMoon02,
            isSelected: themeMode.requireValue == AppThemeMode.dark,
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleDark();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('cancel'.tr()))],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ThemeOption({required this.icon, required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.padded, overlayColor: Colors.transparent),
      onPressed: onPressed,
      child: Row(
        children: [
          HugeIcon(icon: icon, color: isSelected ? Colors.green : context.colorScheme.onSurface),
          SizedBox(width: 10),
          Text(label, style: context.bodyLarge).withColor(isSelected ? Colors.green : context.colorScheme.onSurface),
        ],
      ),
    );
  }
}
